//
//  SheetSizeConverter.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 11/09/2025.
//
import Foundation

// MARK: - SheetSizeConverter

/// Utility to convert relative or absolute values to normalized percentage or absolute points.
enum SheetSizeConverter {
    /// Converts a value to a normalized percentage (0...1) relative to the container size.
    /// - Parameters:
    ///   - value: The value to convert (relative 0...1 or absolute points).
    ///   - isAbsolute: Indicates if the value is absolute (true) or relative (false).
    ///   - containerSize: Maximum container size (width or height).
    /// - Returns: Normalized value between 0 and 1, clamped.
    static func toRelative(
        value: CGFloat,
        isAbsolute: Bool,
        containerSize: CGFloat
    ) -> CGFloat {
        guard containerSize > 0 else {
            return 0
        }
        let percent = isAbsolute ? value / containerSize : value
        return min(max(percent, 0), 1)
    }

    /// Converts a value to absolute points relative to a container size.
    /// - Parameters:
    ///   - value: The value to convert (relative 0...1 or absolute points).
    ///   - isAbsolute: Indicates if the value is absolute (true) or relative (false).
    ///   - containerSize: Maximum container size (width or height).
    /// - Returns: Value in points, clamped between 0 and containerSize.
    static func toAbsolute(
        value: CGFloat,
        isAbsolute: Bool,
        containerSize: CGFloat
    ) -> CGFloat {
        let absoluteValue = isAbsolute ? value : value * containerSize
        return min(max(absoluteValue, 0), containerSize)
    }
}
