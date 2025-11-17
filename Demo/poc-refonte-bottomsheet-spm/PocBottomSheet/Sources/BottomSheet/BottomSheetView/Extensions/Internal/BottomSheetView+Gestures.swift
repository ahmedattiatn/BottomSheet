//
//  BottomSheetView+Gestures.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 22/08/2025.
//
import SwiftUI

extension BottomSheetView {
    /// Returns a drag gesture that updates the sheet’s position and snaps to detents.
    ///
    /// - Parameter availableHeight: The total height available for the sheet.
    /// - Returns: A `DragGesture` configured to handle sheet dragging and snapping.
    func onDrag(from availableHeight: CGFloat) -> some Gesture {
        DragGesture()
            .onChanged { value in
                updateDragBeganInSafeArea(value, availableHeight)
                self.onDragChange(value)
            }
            .updating($translation) { value, state, _ in
                state = value.translation.height
            }
            .onEnded { value in
                snapToNearestDetent(value, availableHeight)
                self.onDragEnd(value)
            }
    }

    // MARK: - Private Helpers

    /// Snaps the sheet to the nearest detent based on drag gesture.
    ///
    /// - Parameters:
    ///   - value: The drag gesture value.
    ///   - availableHeight: The total available height for the sheet.
    private func snapToNearestDetent(
        _ value: DragGesture.Value,
        _ availableHeight: CGFloat
    ) {
        configuration.behavior.detents.current = viewModel.snapToNearestDetent(
            behavior: behavior,
            sheetHeight: sheetHeight(for: availableHeight),
            availableHeight: availableHeight,
            translationHeight: value.translation.height
        )
    }

    /// Updates the view model when dragging begins in the bottom safe area.
    ///
    /// - Parameters:
    ///   - value: The drag gesture value.
    ///   - availableHeight: The total available height for the sheet.
    private func updateDragBeganInSafeArea(
        _ value: DragGesture.Value,
        _ availableHeight: CGFloat
    ) {
        viewModel.updateDragBeganInSafeArea(
            y: value.startLocation.y,
            height: availableHeight - safeAreaInsets.bottom,
            allowsDragFromBottomSafeArea: behavior.drag.allowsDragFromBottomSafeArea
        )
    }
}
