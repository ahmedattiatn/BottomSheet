//
//  BottomSheetView+Metrics.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 19/08/2025.
//

import SwiftUI

extension BottomSheetView {
    /// Computes the height of the sheet based on the current detent and a vertical drag offset.
    ///
    /// - Parameters:
    ///   - availableHeight: The total available height for the sheet.
    ///     **Note:** This value is ignored if the sheet uses `.ignoresSafeArea(edges: .bottom)`.
    ///     In that case, the effective height is:
    ///     `UIScreen.main.bounds.height - safeAreaInsets.top` when the sheet fills the screen.
    /// - Returns: The computed height of the sheet at the current detent, adjusted for the current translation.
    func sheetHeight(for availableHeight: CGFloat) -> CGFloat {
        viewModel.sheetHeight(
            availableHeight: availableHeight,
            translation: translation,
            behavior: behavior
        )
    }
}
