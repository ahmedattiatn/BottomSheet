//
//  BottomSheetView+keyboard.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 19/08/2025.
//

// MARK: - BottomSheetView+Keyboard

extension BottomSheetView {
    // Handling keyboard adjustments for the bottom sheet.
    //
    // Solution A: Use the Protocol KeyboardReader
    //    .padding(
    //        .bottom,
    //        sheetHeight > 0 ? viewModel.keyboardHeight : 0
    //    )
    //
    // Solution B: Use a KeyboardHeight utility
    //    Pros: Smooth animation, follows keyboard height exactly.
    //    Cons: Slightly more setup, requires KeyboardHeight utility.
    //
    //    Example usage:
    //        @StateObject private var keyboardHeight: KeyboardHeight = .init()
    //        .padding(
    //            .bottom,
    //            sheetHeight > 0 ? keyboardHeight.value : 0
    //        )
    //        .animation(configuration.style.animation.value, value: keyboardHeight.value)
    //        .ignoresSafeArea(edges: .bottom)
    //
    // Solution C: Detect only keyboard shown/hidden state
    //    Pros: Minimal setup, easy to reason about.
    //    Cons: Only detects "shown/hidden" state, does not track exact height.
    //
    //    Example usage:
    //        .detectKeyboard($isKeyboardShowing)
    //        // Add padding to keep the bottom sheet anchored to the bottom,
    //        // ignoring safe area bottom insets.
    //        .padding(
    //            .bottom,
    //            isKeyboardShowing ? 0 : -safeAreaInsets.bottom
    //        )
}
