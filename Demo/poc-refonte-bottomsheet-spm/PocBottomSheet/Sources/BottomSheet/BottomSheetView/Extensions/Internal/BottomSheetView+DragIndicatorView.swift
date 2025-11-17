//
//  BottomSheetView+DragIndicatorView.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 19/08/2025.
//

// MARK: - BottomSheetView+DragIndicatorView

import SwiftUI

extension BottomSheetView {
    var dragIndicatorView: some View {
        BottomSheetDragIndicatorView(
            configuration: style.dragIndicator
        )
        .onTapGesture(perform: snapToNextDetent)
        .frame(maxWidth: .infinity)
    }

    private func snapToNextDetent() {
        configuration.behavior.detents.current = viewModel.snapToNextDetent(
            behavior: behavior
        )
        onIndicatorTap()
    }
}
