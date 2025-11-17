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
///   Use `.relative(1)` to fill the full available height (minus safe area insets).
/// - `.absolute(CGFloat)` sets the height to a fixed point value in the container.
public enum SheetDetentHeight: Equatable, Hashable, Comparable {
    /// Height as a fraction of the available height.
    case relative(CGFloat)

    /// Height as an absolute value in points.
    case absolute(CGFloat)

    // MARK: Public

    public static func == (lhs: SheetDetentHeight, rhs: SheetDetentHeight) -> Bool {
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

public extension SheetDetentHeight {
    /// Converts the detent to a normalized percentage (0...1) relative to the available height.
    ///
    /// - Parameter availableHeight: Maximum height of the container in points.
    /// - Returns: A value between 0 and 1 representing the relative height fraction.
    ///            Clamped to ensure it never goes below 0 or above 1.
    /// - Note: If the detent is `.absolute`, it is divided by `availableHeight` to produce the fraction.
    func toRelative(for availableHeight: CGFloat) -> CGFloat {
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
            containerSize: availableHeight
        )
    }

    /// Converts the detent to an absolute height in points based on the available height.
    ///
    /// - Parameter availableHeight: Maximum height of the container in points.
    /// - Returns: The absolute height in points, clamped between 0 and `availableHeight`.
    /// - Note: If the detent is `.relative`, it is multiplied by `availableHeight` to produce the absolute value.
    func toAbsolute(for availableHeight: CGFloat) -> CGFloat {
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
            containerSize: availableHeight
        )
    }
}

public extension [SheetDetentHeight] {
    /// Returns detents sorted from smallest to largest, based on their relative height.
    ///
    /// - Parameter availableHeight: Container height used to normalize absolute detents.
    /// - Returns: Sorted array of detents from lowest to highest.
    func sorted(for availableHeight: CGFloat = ScreenProvider.height) -> [SheetDetentHeight] {
        sorted {
            $0.toRelative(for: availableHeight) < $1.toRelative(for: availableHeight)
        }
    }
}
