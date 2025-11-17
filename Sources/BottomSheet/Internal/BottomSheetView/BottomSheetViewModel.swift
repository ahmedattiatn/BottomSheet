//
//  BottomSheetViewModel.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 18/08/2025.
//

import Foundation

// MARK: - BottomSheetViewModel

/// ViewModel responsible for managing drag gestures, snapping behavior,
/// boundary resistance, and sheet size calculations for a bottom sheet component.
///
/// Runs on the `@MainActor` to safely integrate with SwiftUI state updates.
@MainActor
final class BottomSheetViewModel: ObservableObject {
    // MARK: Internal

    /// Indicates whether a drag started inside the bottom safe area.
    /// Used to prevent snapping or applying drag effects if the gesture started in a restricted area.
    private(set) var dragBeganInSafeArea = false

    // MARK: - Public Methods

    /// Updates the `dragBeganInSafeArea` flag based on where the drag started.
    ///
    /// - Parameters:
    ///   - y: Vertical coordinate where the drag began.
    ///   - height: Maximum available sheet height (typically view height minus safe area insets).
    ///   - allowsDragFromBottomSafeArea: If `true`, the flag is not updated (drag from bottom safe area allowed).
    func updateDragBeganInSafeArea(
        y: CGFloat,
        height: CGFloat,
        allowsDragFromBottomSafeArea: Bool
    ) {
        guard !allowsDragFromBottomSafeArea else {
            return
        }
        dragBeganInSafeArea = y >= height
    }

    /// Computes the effective height of the bottom sheet for the active detent, adjusted by the current drag gesture.
    ///
    /// Applies **drag resistance** at the boundaries (first or last detent) to prevent the sheet
    /// from moving freely past its limits. The resistance factor slows the sheet when dragging
    /// beyond the first or last detent, or when the drag starts in the safe area at the top.
    /// If dragging is disabled (`behavior.drag.isEnabled == false`), the sheet height is
    /// simply the base height of the current detent.
    ///
    /// Works correctly even if there is only **one detent**: in that case,
    /// `firstDetentHeight == lastDetentHeight`, so resistance is applied in both directions
    /// when dragging above or below the single detent.
    ///
    /// - Parameters:
    ///   - availableHeight: The total container height available to the sheet.
    ///   - translation: Vertical drag offset applied to the sheet
    ///                  (positive = downward, negative = upward).
    ///   - behavior: The active `SheetBehavior`, providing detent configuration,
    ///               drag resistance factor, and boundary flags (`isCurrentFirst` / `isCurrentLast`).
    ///
    /// - Returns: The resolved sheet height in points after applying the drag offset and resistance.
    func sheetHeight(
        availableHeight: CGFloat,
        translation: CGFloat,
        behavior: SheetBehavior
    ) -> CGFloat {
        let detents = behavior.detents
        // Step 1: Base height for the current detent
        let baseHeight = availableHeight * detents.current.toRelative(
            for: availableHeight
        )

        // Step 2: If dragging is disabled, just return the base height
        guard behavior.drag.isEnabled else {
            return baseHeight
        }

        // Step 3: Ensure we have valid first and last detent heights
        let firstDetentHeight = detents.values.first?.toAbsolute(
            for: availableHeight
        )
        let lastDetentHeight = detents.values.last?.toAbsolute(
            for: availableHeight
        )
        // Step 4: Raw target height without resistance applied
        let rawHeight = baseHeight - translation

        guard let firstDetentHeight, let lastDetentHeight else {
            return rawHeight
        }
        // Step 5: Determine if resistance should be applied
        // Resistance applies if dragging past the first/last detent or if the drag started in the safe area at the first detent
        let resistanceFactor: CGFloat = (
            (translation < 0 && detents.isCurrentFirst && dragBeganInSafeArea) ||
                rawHeight < firstDetentHeight ||
                rawHeight > lastDetentHeight
        ) ? behavior.drag.resistance : 1

        // Step 6: Apply solid resistance and return the final sheet height
        return targetHeight(
            for: rawHeight,
            resistanceFactor: resistanceFactor,
            firstDetentHeight: firstDetentHeight,
            lastDetentHeight: lastDetentHeight
        )
    }

    // MARK: Private

    /// Applies resistance to the raw height based on first/last detent boundaries.
    ///
    /// - Parameters:
    ///   - rawHeight: Sheet height before resistance is applied.
    ///   - resistanceFactor: Factor applied when dragging beyond detent boundaries to slow movement.
    ///   - firstDetentHeight: Absolute height of the first detent.
    ///   - lastDetentHeight: Absolute height of the last detent.
    ///
    /// - Returns: The final sheet height after applying boundary resistance and overshoot.
    private func targetHeight(
        for rawHeight: CGFloat,
        resistanceFactor: CGFloat,
        firstDetentHeight: CGFloat,
        lastDetentHeight: CGFloat
    ) -> CGFloat {
        if rawHeight < firstDetentHeight {
            // Dragging above the first detent
            firstDetentHeight + (rawHeight - firstDetentHeight) * resistanceFactor
        } else if rawHeight > lastDetentHeight {
            // Dragging beyond the last detent
            lastDetentHeight + (rawHeight - lastDetentHeight) * resistanceFactor
        } else {
            // Within detent range, no extra resistance
            rawHeight
        }
    }
}

// MARK: - BottomSheetViewModel + Detent

extension BottomSheetViewModel {
    /// Determines the detent the sheet should snap to after a drag gesture ends,
    /// considering the current sheet height, drag translation, and vertical velocity.
    ///
    /// Snapping behavior depends on:
    /// - Drag speed (`velocity` vs `velocityThreshold`): fast flicks snap immediately to next/previous detent.
    /// - Slow drags: progress compared directly against nearest detent.
    /// - Minimum movement threshold (`minSnapPercent`): prevents tiny movements from triggering a snap.
    ///
    /// - Parameters:
    ///   - behavior: Sheet behavior configuration (detents, drag rules, etc.).
    ///   - sheetHeight: Current absolute height of the sheet in points.
    ///   - availableHeight: Maximum container height available for the sheet.
    ///   - translation: Vertical drag offset applied (positive = down, negative = up).
    ///   - velocity: Drag velocity in points per second (negative = upward, positive = downward).
    ///
    /// - Returns: The detent to snap to. Returns the current detent if snapping is prevented
    ///            (drag disabled, started in safe area, or movement below `minSnapPercent`).
    func snapToNearestDetent(
        behavior: SheetBehavior,
        sheetHeight: CGFloat,
        availableHeight: CGFloat,
        translation: CGFloat,
        velocity: CGFloat
    ) -> SheetDetentHeight {
        let detents = behavior.detents
        let currentDetent = detents.current

        // Return current detent if dragging is disabled, drag started in safe area,
        // no detents exist, or availableHeight is invalid
        guard behavior.drag.isEnabled,
              !dragBeganInSafeArea,
              !detents.values.isEmpty,
              availableHeight > 0
        else {
            return currentDetent
        }

        // Step 1: Fast flick detection
        // If the drag velocity exceeds the threshold, snap immediately to next/previous detent
        if abs(velocity) > behavior.drag.velocityThreshold {
            // velocity < 0 means upward swipe (snap forward)
            return snap(to: velocity < 0 ? .next : .previous, from: detents)
        }

        // Step 2: Normalize detent positions
        // Convert detents and current position to relative values (0...1)
        let detentsPercent = detents.values.map { $0.toRelative(for: availableHeight) }
        let currentPercent = currentDetent.toRelative(for: availableHeight)

        // Current drag progress as a percentage of available height
        let progress = min(max((sheetHeight - translation) / availableHeight, 0), 1)

        // Step 3: Find the nearest detent
        // Compare progress to all detent positions and pick the closest one
        let nearestIndex = detentsPercent.enumerated()
            .min { abs($0.element - progress) < abs($1.element - progress) }?
            .offset ?? 0

        // Step 4: Apply minimum snap threshold
        // Snap only if movement exceeds minimum snap threshold
        return abs(detentsPercent[nearestIndex] - currentPercent) > behavior.drag.minSnapPercent
            ? detents.values[nearestIndex]
            : currentDetent
    }

    /// Determines the target detent to snap to, based on the given direction.
    ///
    /// Uses the provided `SheetSnapDirection` to determine the next or previous detent
    /// relative to the current context.
    ///
    /// - Parameters:
    ///   - direction: The snap direction (`.next` for the following detent, `.previous` for the preceding one).
    ///   - detents: The detent context providing access to the current, next, and previous detents.
    /// - Returns: The resolved target detent height. If no adjacent detent exists,
    ///            the current detent is returned.
    func snap(
        to direction: SheetSnapDirection,
        from detents: SheetDetent
    ) -> SheetDetentHeight {
        direction == .next ? detents.next : detents.previous
    }
}
