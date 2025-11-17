//
//  View+DynamicSize.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 18/08/2025.
//

import SwiftUI

// MARK: - DynamicSize

struct DynamicSize: ViewModifier {
    // MARK: Lifecycle

    init(size: Binding<CGSize>) { _size = size }

    // MARK: Internal

    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear { size = proxy.size }
                        .onChange(of: proxy.size) { size = $0 }
                }
            )
    }
}

extension View {
    func dynamicSize(_ size: Binding<CGSize>) -> some View {
        modifier(DynamicSize(size: size))
    }
}
