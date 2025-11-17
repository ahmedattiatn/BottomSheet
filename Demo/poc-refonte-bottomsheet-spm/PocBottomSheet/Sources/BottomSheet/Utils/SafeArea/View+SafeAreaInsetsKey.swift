//
//  View+SafeAreaInsetsKey.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 18/08/2025.
//
import SwiftUI

// MARK: - SafeAreaInsetsKey

// This extension is currently unused, but it can be useful
// if we ever need to observe SafeAreaInsets in real time.

/// A `PreferenceKey` used to propagate the current safe area insets
/// through the SwiftUI view hierarchy.
///
/// ⚠️ If `.ignoresSafeArea()` is applied, the insets will always be `(0, 0, 0, 0)`.
private struct SafeAreaInsetsKey: PreferenceKey {
    static var defaultValue = EdgeInsets()

    static func reduce(value: inout EdgeInsets, nextValue: () -> EdgeInsets) {
        value = nextValue()
    }
}

extension View {
    func getSafeAreaInsets(_ safeInsets: Binding<EdgeInsets>) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: SafeAreaInsetsKey.self, value: proxy.safeAreaInsets)
            }
            .onPreferenceChange(SafeAreaInsetsKey.self) { value in
                safeInsets.wrappedValue = value
            }
        )
    }
}
