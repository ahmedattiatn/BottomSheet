//
//  SheetBorder.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 20/08/2025.
//
import SwiftUI

/// Represents a border configuration for a bottom sheet,
/// including color, line width, and corner radius.
public struct SheetBorder: Equatable {
    // MARK: Lifecycle

    /// Creates a new `SheetBorder` with the specified properties.
    ///
    /// - Parameters:
    ///   - color: Border color. Defaults to `defaultValue.color`.
    ///   - width: Border line width in points. Defaults to `defaultValue.width`.
    ///   - radius: Corner radius in points. Defaults to `defaultValue.radius`.
    public init(
        color: Color = defaultValue.color,
        width: CGFloat = defaultValue.width,
        radius: CGFloat = defaultValue.radius
    ) {
        self.color = color
        self.width = width
        self.radius = radius
    }

    // MARK: Public

    /// Default border configuration (clear color, 1pt width, 16pt radius).
    public static let defaultValue: SheetBorder = .init(
        color: .clear,
        width: 1,
        radius: 16
    )

    /// Border color.
    public var color: Color
    /// Border line width in points.
    public let width: CGFloat
    /// Corner radius in points.
    public let radius: CGFloat
}
