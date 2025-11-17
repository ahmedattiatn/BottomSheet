//
//  BottomSheetViewModel.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 18/08/2025.
//

import Foundation

// MARK: - BottomSheetViewModel

/// ViewModel responsible for managing drag gestures, snapping behavior,
/// and width/height calculations for a bottom sheet component.
///
/// Runs on the `@MainActor` to safely integrate with SwiftUI state updates.
@MainActor
final class BottomSheetViewModel: ObservableObject {
    /// Indicates whether a drag started inside the bottom safe area.
    /// Read-only from outside the ViewModel.
    private(set) var dragBeganInSafeArea = false

    // MARK: - Public Methods

    /// Computes a vertical offset for a drag translation, ensuring
    /// the sheet does not move above its starting position.
    /// - Parameter translation: Vertical drag translation.
    /// - Returns: Non-negative offset for the sheet.
    func yOffset(for translation: CGFloat) -> CGFloat {
        max(translation, 0)
    }

    /// Updates the `dragBeganInSafeArea` flag based on where the drag started.
    /// - Parameters:
    ///   - y: Vertical coordinate where the drag began.
    ///   - height: Maximum available height for the sheet
    ///             (typically the view height minus any relevant safe area insets).
    ///   - allowsDragFromBottomSafeArea: Indicates whether dragging from
    ///             the bottom safe area is allowed. If `true`, the flag is not updated.
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

    /// Computes the effective width of the bottom sheet based on its configuration.
    /// - Parameters:
    ///   - sheetWidth: Configured sheet width, either relative (0...1) or absolute.
    ///   - availableWidth: Maximum width available, accounting for safe area insets.
    /// - Returns: The final width of the sheet, clamped to the available width if necessary.
    func adjustedWidth(
        sheetWidth: SheetWidth,
        availableWidth: CGFloat
    ) -> CGFloat {
        switch sheetWidth {
        case let .relative(percent):
            return availableWidth * min(max(percent, 0), 1) // Clamp between 0 and 1
        case let .absolute(value):
            return min(value, availableWidth)
        }
    }

    /// Computes the sheet height for the currently selected detent.
    /// - Parameters:
    ///   - availableHeight: Height available for the sheet.
    ///   - currentDetent: Currently active detent.
    /// - Returns: Height of the sheet in points.
    func sheetHeight(
        availableHeight: CGFloat,
        currentDetent: SheetDetentHeight
    ) -> CGFloat {
        availableHeight * currentDetent.toRelative(for: availableHeight)
    }
}

// MARK: - BottomSheetViewModel + Detent

extension BottomSheetViewModel {
    /// Determines the detent the sheet should snap to after a drag gesture ends.
    /// - Parameters:
    ///   - behavior: Sheet behavior configuration (detents and drag rules).
    ///   - sheetHeight: Current height of the sheet.
    ///   - availableHeight: Maximum possible height (accounting for safe area insets).
    ///   - translationHeight: Vertical translation from the drag gesture.
    /// - Returns: The detent to snap to. Returns the current detent if snapping is prevented
    ///   (e.g., drag disabled, drag started in safe area, or movement too small).
    func snapToNearestDetent(
        behavior: SheetBehavior,
        sheetHeight: CGFloat,
        availableHeight: CGFloat,
        translationHeight: CGFloat
    ) -> SheetDetentHeight {
        let detents = behavior.detents.values
        let currentDetent = behavior.detents.current

        guard behavior.drag.isEnabled,
              !dragBeganInSafeArea,
              !detents.isEmpty else {
            return currentDetent
        }

        let detentsPercent = detents.map { $0.toRelative(for: availableHeight) }
        let currentPercent = currentDetent.toRelative(for: availableHeight)
        let progress = min(max((sheetHeight - translationHeight) / availableHeight, 0), 1)

        // Optimize for two-detent scenario
        if detents.count == 2 {
            return detents[translationHeight < 0 ? 1 : 0]
        }

        // Find nearest detent to the drag progress
        let nearestIndex = detentsPercent.enumerated()
            .min { abs($0.element - progress) < abs($1.element - progress) }?
            .offset ?? 0

        // Snap only if movement exceeds minimum snap threshold
        return abs(detentsPercent[nearestIndex] - currentPercent) > behavior.drag.minSnapPercent
            ? detents[nearestIndex]
            : currentDetent
    }

    /// Moves to the next or previous detent programmatically.
    /// Wraps around when reaching the first or last detent.
    /// - Parameters:
    ///   - behavior: Sheet behavior configuration.
    ///   - forward: `true` moves forward; `false` moves backward.
    /// - Returns: The detent to move to.
    func snapToNextDetent(
        behavior: SheetBehavior,
        forward: Bool = true
    ) -> SheetDetentHeight {
        guard behavior.drag.isEnabled,
              !behavior.detents.values.isEmpty,
              let currentIndex = behavior.detents.values.firstIndex(
                  of: behavior.detents.current
              ) else {
            return behavior.detents.current
        }

        let nextIndex: Int = forward
            ? (currentIndex + 1) % behavior.detents.values.count
            : (currentIndex - 1 + behavior.detents.values.count) % behavior.detents.values.count

        return behavior.detents.values[nextIndex]
    }
}
