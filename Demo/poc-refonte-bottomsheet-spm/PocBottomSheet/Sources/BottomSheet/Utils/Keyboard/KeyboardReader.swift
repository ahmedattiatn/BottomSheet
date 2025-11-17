//
//  KeyboardReader.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 18/08/2025.
//

import Combine
import SwiftUI

// MARK: - KeyboardReader

/// Protocol that provides publishers for keyboard visibility and height.
/// Can be used to reactively adjust UI when the keyboard appears or disappears.
protocol KeyboardReader {
    var keyboardVisiblePublisher: AnyPublisher<Bool, Never> { get }
    var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> { get }
}

extension KeyboardReader {
    /// Publisher that emits `true` when the keyboard will show, and `false` when it will hide.
    var keyboardVisiblePublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }

    /// Publisher that emits the keyboard height when it shows, and `0` when it hides.
    var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
                .map(\.height),
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in 0 }
        )
        .eraseToAnyPublisher()
    }
}

// MARK: - Example 1: Inline Keyboard Handling in View

/// Demonstrates using `KeyboardReader` directly in a SwiftUI view.
/// Pros: Simple, minimal boilerplate.
/// Cons: Keyboard height is not directly exposed for layout calculations.
private struct KeyboardExampleView: View, KeyboardReader {
    // MARK: Internal

    var body: some View {
        TextField("Text", text: $text)
            .onReceive(keyboardVisiblePublisher) { newIsKeyboardVisible in
                // Update local state when keyboard visibility changes
                print("Is keyboard visible? ", newIsKeyboardVisible)
                isKeyboardVisible = newIsKeyboardVisible
            }
    }

    // MARK: Private

    @State private var text: String = ""
    @State private var isKeyboardVisible = false
}

// MARK: - Example 2: Using a ViewModel to Track Keyboard Height

/// ViewModel approach for tracking keyboard height using `KeyboardReader`.
/// Pros: Smooth animations, height value can be used for layout adjustments.
/// Cons: Slightly more boilerplate compared to inline approach.
@MainActor
final class KeyboardSecondExampleViewModel: ObservableObject, KeyboardReader {
    // MARK: Lifecycle

    init() {
        bindKeyboardHeightPublisher()
    }

    // MARK: Internal

    @Published private(set) var keyboardHeight: CGFloat = 0

    /// Subscribes to keyboard height updates and assigns them to `keyboardHeight`.
    func bindKeyboardHeightPublisher() {
        keyboardHeightPublisher
            .receive(on: RunLoop.main)
            .assign(to: &$keyboardHeight)
    }
}

private struct KeyboardSecondExampleView: View {
    // MARK: Lifecycle

    init() {
        self._viewModel = StateObject(
            wrappedValue: .init()
        )
    }

    // MARK: Internal

    @StateObject var viewModel: KeyboardSecondExampleViewModel

    var body: some View {
        TextField("Text", text: $text)
            .padding(.bottom, viewModel.keyboardHeight)
        // Optional: animate changes if desired
    }

    // MARK: Private

    @State private var text: String = ""
    @State private var keyboardHeight: CGFloat = 0
}
