//
//  SheetShadow.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 21/08/2025.
//

import SwiftUI

/// Represents a shadow configuration for a bottom sheet,
/// including color, blur radius, and offset values.
public struct SheetShadow: Equatable {
    // MARK: Lifecycle

    /// Creates a new `SheetShadow` with the specified properties.
    ///
    /// - Parameters:
    ///   - color: The shadow color.
    ///   - radius: The blur radius of the shadow.
    ///   - x: Horizontal offset of the shadow.
    ///   - y: Vertical offset of the shadow.
    public init(
        color: Color,
        radius: CGFloat,
        x: CGFloat,
        y: CGFloat
    ) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }

    // MARK: Public

    /// Default shadow value (no shadow).
    public static let defaultValue: SheetShadow = .init(
        color: .clear,
        radius: 0,
        x: 0,
        y: 0
    )

    /// The shadow color.
    public let color: Color
    /// The blur radius of the shadow.
    public let radius: CGFloat
    /// The horizontal offset of the shadow.
    public let x: CGFloat
    /// The vertical offset of the shadow.
    public let y: CGFloat
}
