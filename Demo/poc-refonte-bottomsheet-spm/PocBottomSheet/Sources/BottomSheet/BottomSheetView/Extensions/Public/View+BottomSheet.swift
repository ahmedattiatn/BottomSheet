//
//  View+BottomSheet.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 21/08/2025.
//

import SwiftUI

public extension View {
    func BottomSheet(
        isPresented: Binding<Bool>,
        configuration: Binding<SheetConfiguration>,
        @ViewBuilder content: () -> some View
    ) -> some View {
        BottomSheetView(
            isPresented: isPresented,
            configuration: configuration,
            content: content
        )
    }
}
