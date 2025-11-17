//
//  BottomSheetView+DragIndicatorView.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 19/08/2025.
//

// MARK: - BottomSheetView+DragIndicatorView

import SwiftUI

extension BottomSheetView {
    /// A visual drag indicator displayed at the top of the bottom sheet.
    ///
    /// - Uses the `style.dragIndicator` configuration to style the indicator.
    /// - Tapping the indicator triggers a snap to the next or previous detent.
    var dragIndicatorView: some View {
        BottomSheetDragIndicatorView(
            configuration: style.dragIndicator
        )
        .onTapGesture(perform: snapToNextOrPreviousDetent)
        .frame(maxWidth: .infinity)
    }

    /// Handles a tap on the drag indicator.
    ///
    /// - Updates the sheet’s current detent to the next or previous detent
    ///   if snapping is allowed (drag indicator enabled).
    /// - After updating the detent, invokes the `onIndicatorTap` callback.
    private func snapToNextOrPreviousDetent() {
        if style.dragIndicator.isEnabled {
            configuration.behavior.detents.update(
                current: viewModel.snap(
                    to: !behavior.detents.isCurrentLast ? .next : .previous,
                    from: behavior.detents
                )
            )
            onIndicatorTap()
        }
    }
}
