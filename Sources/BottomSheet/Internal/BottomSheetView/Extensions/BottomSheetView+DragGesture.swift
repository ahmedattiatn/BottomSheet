//
//  BottomSheetView+DragGesture.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 22/08/2025.
//

import SwiftUI

extension BottomSheetView {
    /// Returns a vertical-only drag gesture for the bottom sheet.
    ///
    /// This gesture ignores horizontal drags to avoid interfering with
    /// gestures inside the sheet (e.g., `List` swipe-to-delete).
    /// It handles drag updates, resistance, and snapping behavior,
    /// and dismisses the keyboard if active.
    ///
    /// - Parameter availableHeight: The total height available to the sheet container.
    /// - Returns: A configured `DragGesture` that updates the sheet's position
    ///            and snaps it to the nearest detent when released.
    func onVerticalDrag(from availableHeight: CGFloat) -> some Gesture {
        DragGesture(minimumDistance: behavior.drag.minimumDistance)
            .onChanged { onDragChanged($0, availableHeight) }
            .updating($translation) { value, state, _ in
                // Only track vertical movement
                guard abs(value.translation.height) > abs(value.translation.width) else {
                    return
                }
                state = value.translation.height
            }
            .onEnded { onDragEnded($0, availableHeight) }
    }

    // MARK: - Private Helpers

    /// Handles updates during the drag gesture.
    ///
    /// Filters out horizontal drags, updates the drag direction,
    /// checks safe area restrictions, invokes the `onDragChange` callback,
    /// and dismisses the keyboard.
    ///
    /// - Parameters:
    ///   - value: The current drag gesture value.
    ///   - availableHeight: The total available height for the sheet.
    private func onDragChanged(
        _ value: DragGesture.Value,
        _ availableHeight: CGFloat
    ) {
        // Only track vertical movement
        guard abs(value.translation.height) > abs(value.translation.width) else {
            return
        }
        dragDirection = value.translation.height > translation ? .down : .up
        handleDragBeganInSafeArea(value, availableHeight)
        if !viewModel.dragBeganInSafeArea {
            onDragChange(value, dragDirection)
        }
        dismissKeyboard()
    }

    /// Handles the end of the drag gesture.
    ///
    /// Filters out horizontal drags, invokes the `onDragEnd` callback,
    /// resets the drag direction, and snaps the sheet to the nearest detent.
    ///
    /// - Parameters:
    ///   - value: The final drag gesture value.
    ///   - availableHeight: The total available height for the sheet.
    private func onDragEnded(
        _ value: DragGesture.Value,
        _ availableHeight: CGFloat
    ) {
        onDragEnd(value)
        // Only track vertical movement
        guard abs(value.translation.height) > abs(value.translation.width) else {
            return
        }
        dragDirection = .none
        snapToNearestDetent(value, availableHeight)
    }

    /// Snaps the sheet to the nearest detent based on the drag gesture’s translation and velocity.
    ///
    /// - Parameters:
    ///   - value: The drag gesture value.
    ///   - availableHeight: The total available height for the sheet.
    private func snapToNearestDetent(
        _ value: DragGesture.Value,
        _ availableHeight: CGFloat
    ) {
        configuration.behavior.detents.update(
            current: viewModel.snapToNearestDetent(
                behavior: behavior,
                sheetHeight: sheetHeight(for: availableHeight),
                availableHeight: availableHeight,
                translation: value.translation.height,
                velocity: value.velocity.height
            )
        )
    }

    /// Handles drag starting in the bottom safe area.
    ///
    /// Updates the view model to track whether the drag began in the bottom safe area.
    ///
    /// - Parameters:
    ///   - value: The drag gesture value.
    ///   - availableHeight: The total available height for the sheet.
    private func handleDragBeganInSafeArea(
        _ value: DragGesture.Value,
        _ availableHeight: CGFloat
    ) {
        viewModel.updateDragBeganInSafeArea(
            y: value.startLocation.y,
            height: availableHeight - safeAreaInsets.bottom,
            allowsDragFromBottomSafeArea: behavior.drag.allowsDragFromBottomSafeArea
        )
    }

    /// Dismisses the keyboard by ending editing on the current key window.
    ///
    /// Typically called during drag gestures to ensure the keyboard does not remain onscreen.
    private func dismissKeyboard() {
        UIApplication.shared.endEditing()
    }
}
