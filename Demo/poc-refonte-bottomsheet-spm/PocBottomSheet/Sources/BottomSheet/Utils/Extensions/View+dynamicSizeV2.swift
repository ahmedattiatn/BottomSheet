//
//  View+dynamicSizeV2.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 05/09/2025.
//

import SwiftUI

// MARK: - SizePreference

/// PreferenceKey to capture CGSize
struct SizePreference: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        // Pick the larger width and height
        let next = nextValue()
        value.width = max(value.width, next.width)
        value.height = max(value.height, next.height)
    }
}

extension View {
    /// Reads the rendered size and writes it into a Binding<CGSize>
    func dynamicSizeV2(_ size: Binding<CGSize>) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: SizePreference.self, value: proxy.size)
            }
        )
        .onPreferenceChange(SizePreference.self) { newSize in
            if size.wrappedValue != newSize {
                size.wrappedValue = newSize
            }
        }
    }
}
