//
//  BottomSheetView+Metrics.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 19/08/2025.
//

import SwiftUI

extension BottomSheetView {
    /// Computes the height of the sheet based on the current detent.
    ///
    /// - Parameter availableHeight: The total available height for the sheet.
    ///   **Note:** This value is ignored if the sheet uses `.ignoresSafeArea(edges: .bottom)`.
    ///   This is equivalent to:
    ///   `UIScreen.main.bounds.height - safeAreaInsets.top`
    ///   when the sheet fills the screen.
    /// - Returns: The computed height for the sheet at the current detent.
    func sheetHeight(for availableHeight: CGFloat) -> CGFloat {
        viewModel.sheetHeight(
            availableHeight: availableHeight,
            currentDetent: behavior.detents.current
        )
    }

    /// Computes the width of the sheet adjusted to fit the screen or the configured content width.
    ///
    /// - Parameter availableWidth: The total available width for the sheet.
    ///   **Note:** This value is ignored if the sheet fills the screen.
    ///   This is equivalent to:
    ///   `UIScreen.main.bounds.width - safeAreaInsets.leading - safeAreaInsets.trailing`.
    /// - Returns: The adjusted width for the sheet.
    func adjustedWidth(for availableWidth: CGFloat) -> CGFloat {
        viewModel.adjustedWidth(
            sheetWidth: behavior.width,
            availableWidth: availableWidth
        )
    }
}
