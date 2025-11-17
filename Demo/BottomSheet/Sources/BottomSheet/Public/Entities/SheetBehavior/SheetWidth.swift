//
//  SheetWidth.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 03/09/2025.
//

import Foundation

// MARK: - SheetWidth

/// `SheetWidth` defines the possible widths that can be configured for a bottom sheet.
///
/// Options:
/// - `.relative(CGFloat)` sets the width as a fraction of the available width (0...1).
///   Use `.relative(1)` to take the full available width (minus safe area insets).
/// - `.absolute(CGFloat)` sets the width to a fixed point value.
public enum SheetWidth: Equatable, Hashable {
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
            a == b
        case let (.absolute(a), .absolute(b)):
            a == b
        default:
            false
        }
    }
}

public extension SheetWidth {
    /// Converts the width to a normalized percentage (0...1) relative to the available width.
    ///
    /// - Parameter availableWidth: Maximum width of the container in points.
    /// - Returns: A value between 0 and 1 representing the relative width fraction.
    ///            Clamped to ensure it never goes below 0 or above 1.
    /// - Note: If the width is `.absolute`, it is divided by `availableWidth` to produce the fraction.
    func toRelative(for availableWidth: CGFloat) -> CGFloat {
        let (value, isAbsolute): (CGFloat, Bool) = {
            switch self {
            case let .absolute(v):
                (v, true)
            case let .relative(v):
                (v, false)
            }
        }()
        return SheetSizeConverter.toRelative(
            value: value,
            isAbsolute: isAbsolute,
            containerSize: availableWidth
        )
    }

    /// Converts the width to an absolute value in points based on the available width.
    ///
    /// - Parameter availableWidth: Maximum width of the container in points.
    /// - Returns: The absolute width in points, clamped between 0 and `availableWidth`.
    /// - Note: If the width is `.relative`, it is multiplied by `availableWidth` to produce the absolute value.
    func toAbsolute(for availableWidth: CGFloat) -> CGFloat {
        let (value, isAbsolute): (CGFloat, Bool) = {
            switch self {
            case let .absolute(v):
                (v, true)
            case let .relative(v):
                (v, false)
            }
        }()
        return SheetSizeConverter.toAbsolute(
            value: value,
            isAbsolute: isAbsolute,
            containerSize: availableWidth
        )
    }
}
