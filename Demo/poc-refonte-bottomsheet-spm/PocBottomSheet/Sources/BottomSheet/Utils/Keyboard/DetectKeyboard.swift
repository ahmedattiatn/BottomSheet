//
//  DetectKeyboard.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 18/08/2025.
//

import SwiftUI

// MARK: - DetectKeyboard

/// A ViewModifier that detects when the keyboard appears or disappears.
///
/// This modifier observes changes in the bottom safe area inset to determine
/// keyboard visibility and updates a bound `Bool` accordingly.
///
/// Currently unused, but useful for adjusting views like bottom sheets
/// when the keyboard appears.
struct DetectKeyboard: ViewModifier {
    // MARK: Internal

    /// Binding that will be updated with the current keyboard visibility.
    @Binding var isKeyboardShowing: Bool

    func body(content: Content) -> some View {
        ZStack {
            // Track the bottom safe area inset without considering the keyboard
            Color.clear
                .onGeometryChange(for: CGFloat.self, of: \.safeAreaInsets.bottom) { bottomInset in
                    bottomInsetWithoutKeyboard = bottomInset
                }
                .ignoresSafeArea(.keyboard) // Ensure inset detection ignores keyboard

            // Track the bottom safe area inset with keyboard
            Color.clear
                .onGeometryChange(for: CGFloat.self, of: \.safeAreaInsets.bottom) { bottomInset in
                    bottomInsetWithKeyboard = bottomInset
                }

            content
        }
        // Update the binding when keyboard visibility changes
        // iOS 17: .onChange(of: isKeyboardDetected) { _, newVal in
        .onChange(of: isKeyboardDetected) { newVal in
            isKeyboardShowing = newVal
        }
    }

    // MARK: Private

    /// Stores the bottom inset without the keyboard
    @State private var bottomInsetWithoutKeyboard: CGFloat?

    /// Stores the bottom inset with the keyboard
    @State private var bottomInsetWithKeyboard: CGFloat?

    /// Determines whether the keyboard is currently visible
    private var isKeyboardDetected: Bool {
        if let bottomInsetWithoutKeyboard, let bottomInsetWithKeyboard {
            return bottomInsetWithoutKeyboard != bottomInsetWithKeyboard
        } else {
            return false
        }
    }
}

// MARK: - View Extension

extension View {
    /// Adds the DetectKeyboard modifier to a view.
    /// - Parameter isKeyboardShowing: Binding updated with keyboard visibility.
    func detectKeyboard(_ isKeyboardShowing: Binding<Bool>) -> some View {
        modifier(DetectKeyboard(isKeyboardShowing: isKeyboardShowing))
    }
}
