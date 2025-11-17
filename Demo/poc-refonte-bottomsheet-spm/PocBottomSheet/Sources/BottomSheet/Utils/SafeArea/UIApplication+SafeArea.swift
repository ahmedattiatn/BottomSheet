//
//  UIApplication+SafeArea.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 18/08/2025.
//

import SwiftUI

// MARK: - SafeAreaInsets

/// Provides the “real” safe area insets of the key window,
/// even if `.ignoresSafeArea()` is used in SwiftUI views.
///
/// Use `SafeAreaInsets.value` when you need to calculate layout
/// manually or adjust views according to the device’s true safe area.
enum SafeAreaInsets {
    static var value: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
    }
}

// MARK: - SafeAreaInsetsKey

/// Environment key for accessing the current safe area insets.
private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        SafeAreaInsets.value
    }
}

extension EnvironmentValues {
    /// Access the current safe area insets through the environment.
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

// MARK: - UIEdgeInsets Conversion

private extension UIEdgeInsets {
    /// Converts UIKit `UIEdgeInsets` to SwiftUI `EdgeInsets`.
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

// MARK: - UIApplication Helper

private extension UIApplication {
    /// Returns the current key window, if available.
    /// Iterates over connected scenes to find the active window.
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }
    }
}
