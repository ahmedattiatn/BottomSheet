//
//  SheetDragIndicator.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 18/08/2025.
//
import SwiftUI

// MARK: - SheetDragIndicator

public struct SheetDragIndicator: Equatable {
    // MARK: Lifecycle

    public init(
        height: CGFloat,
        width: CGFloat,
        radius: CGFloat,
        color: Color,
        padding: EdgeInsets
    ) {
        self.height = height
        self.width = width
        self.radius = radius
        self.color = color
        self.padding = padding
    }

    // MARK: Public

    public static let defaultValue: SheetDragIndicator = .init(
        height: 6,
        width: 30,
        radius: 16,
        color: Color.secondary,
        padding: .tiny
    )

    public var height: CGFloat
    public var width: CGFloat
    public var radius: CGFloat
    public var color: Color
    public let padding: EdgeInsets
}
