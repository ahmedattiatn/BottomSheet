//
//  BottomSheetDragIndicatorView.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 18/08/2025.
//

import SwiftUI

struct BottomSheetDragIndicatorView: View {
    let configuration: SheetDragIndicator

    var body: some View {
        RoundedRectangle(cornerRadius: configuration.radius)
            .fill(configuration.color)
            .frame(
                width: configuration.width,
                height: configuration.height
            )
            .padding(configuration.padding)
    }
}
