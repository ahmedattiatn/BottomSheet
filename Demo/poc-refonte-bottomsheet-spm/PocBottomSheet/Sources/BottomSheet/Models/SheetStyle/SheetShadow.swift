//
//  SheetShadow.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 21/08/2025.
//

import SwiftUI

public struct SheetShadow: Equatable {
    // MARK: Lifecycle

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

    public static let defaultValue: SheetShadow = .init(
        color: Color(.sRGBLinear, white: 0, opacity: 0.33),
        radius: 5,
        x: 0,
        y: 0
    )

    public var color: Color
    public var radius: CGFloat
    public var x: CGFloat
    public var y: CGFloat
}
