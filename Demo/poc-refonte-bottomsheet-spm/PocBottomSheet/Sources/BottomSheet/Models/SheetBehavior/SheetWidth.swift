//
//  SheetWidth.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 03/09/2025.
//

import Foundation

/// `SheetWidth` defines the possible widths that can be configured for a bottom sheet.
///
/// Options:
/// - `.relative(CGFloat)` sets the width as a fraction of the available width (0...1).
///   Use `.relative(1)` to take the full available width (minus safe area insets).
/// - `.absolute(CGFloat)` sets the width to a fixed point value.
public enum SheetWidth: Equatable {
    /// Width as a fraction of the available width after subtracting safe area insets.
    /// Only values between 0 and 1 are valid.
    case relative(CGFloat)

    /// Width as an absolute value in points.
    /// Only values greater than 0 are valid.
    case absolute(CGFloat)

    // MARK: Public

    public static func == (lhs: SheetWidth, rhs: SheetWidth) -> Bool {
        switch (lhs, rhs) {
        case let (.relative(a), .relative(b)):
            return a == b
        case let (.absolute(a), .absolute(b)):
            return a == b
        default:
            return false
        }
    }
}
