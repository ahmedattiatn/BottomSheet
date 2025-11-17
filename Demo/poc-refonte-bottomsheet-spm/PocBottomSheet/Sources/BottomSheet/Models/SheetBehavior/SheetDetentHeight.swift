//
//  SheetDetentHeight.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 03/09/2025.
//

import Foundation

// MARK: - SheetDetentHeight

/// `SheetDetentHeight` defines the possible snap points (detents) for a bottom sheet.
///
/// Options:
/// - `.relative(CGFloat)` sets the height as a fraction of the available height (0...1).
///   Use `.relative(1)` to take the full available height (minus safe area insets).
/// - `.absolute(CGFloat)` sets the height to a fixed point value.
public enum SheetDetentHeight: Equatable, Hashable {
    /// Height as a fraction of the available height after subtracting safe area insets.
    /// Only values between 0 and 1 are valid.
    case relative(CGFloat)

    /// Height as an absolute value in points.
    /// Only values greater than 0 are valid.
    case absolute(CGFloat)

    // MARK: Public

    public static func == (lhs: SheetDetentHeight, rhs: SheetDetentHeight) -> Bool {
        switch (lhs, rhs) {
        case let (.relative(a), .relative(b)):
            return a == b
        case let (.absolute(a), .absolute(b)):
            return a == b
        default:
            return false
        }
    }

    // MARK: Internal

    /// Converts the detent to a normalized percentage (0...1)
    /// relative to the available height.
    /// - Parameter availableHeight: Maximum height of the sheet container.
    func toRelative(for availableHeight: CGFloat) -> CGFloat {
        let rawPercent = switch self {
        case let .absolute(value):
            // Avoid division by zero when computing the ratio
            availableHeight > 0 ? value / availableHeight : 0
        case let .relative(value):
            value
        }

        // Clamp result to ensure it's always between 0 and 1
        return min(max(rawPercent, 0), 1)
    }

    /// Converts the detent to an absolute height in points.
    /// - Parameter availableHeight: Maximum height of the sheet container.
    func toAbsolute(for availableHeight: CGFloat) -> CGFloat {
        switch self {
        case let .absolute(value): value
        case let .relative(value): value * availableHeight
        }
    }
}

public extension Array where Element == SheetDetentHeight {
    /// Returns detents sorted from lowest to highest based on the provided available height.
    /// - Parameter availableHeight: The container height used to normalize absolute
    ///   detents. Defaults to the current screen height (`ScreenProvider.height`).
    /// - Returns: A new array of detents sorted from smallest to largest.
    func sorted(for availableHeight: CGFloat = ScreenProvider.height) -> [SheetDetentHeight] {
        sorted {
            $0.toRelative(for: availableHeight) < $1.toRelative(for: availableHeight)
        }
    }
}
