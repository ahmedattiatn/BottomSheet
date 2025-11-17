//
//  KeyboardHeight.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 18/08/2025.
//

import Foundation
import SwiftUI

// MARK: - KeyboardHeight

/// ObservableObject that tracks the height of the keyboard.
///
/// Use this class in SwiftUI views to adjust layout dynamically
/// when the keyboard appears or disappears. Currently unused, but
/// can be helpful for bottom sheets, forms, or any view that needs
/// to respond to keyboard height changes.
class KeyboardHeight: ObservableObject {
    // MARK: Lifecycle

    init() {
        // Observe keyboard show/hide notifications
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // MARK: Internal

    // MARK: Published Properties

    /// Current keyboard height. `0` if keyboard is hidden.
    @Published private(set) var value: CGFloat = 0

    // MARK: Private

    // MARK: Private Methods

    /// Handles keyboard show notification and updates `value` with keyboard height.
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            DispatchQueue.main.async {
                self.value = keyboardFrame.cgRectValue.height
            }
        }
    }

    /// Handles keyboard hide notification and resets `value` to `0`.
    @objc private func keyboardWillHide(_: Notification) {
        DispatchQueue.main.async {
            self.value = 0
        }
    }
}

// MARK: - KeyboardExampleView

/// Example SwiftUI view showing how to use `KeyboardHeight`.
///
/// Adjusts bottom padding of a `TextField` dynamically based on the keyboard height.
private struct KeyboardExampleView: View {
    // MARK: Internal

    var body: some View {
        TextField("Text", text: $text)
            .padding(.bottom, keyboardHeight.value)
        // Optionally, add animation if you want smooth padding changes
        // .animation(.easeOut, value: keyboardHeight.value)
    }

    // MARK: Private

    @ObservedObject private var keyboardHeight: KeyboardHeight = .init()
    @State private var text: String = ""
}
