//
//  SheetBorder.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 20/08/2025.
//
import SwiftUI

public struct SheetBorder: Equatable {
    // MARK: Lifecycle

    public init(
        color: Color,
        width: CGFloat,
        radius: CGFloat
    ) {
        self.color = color
        self.width = width
        self.radius = radius
    }

    // MARK: Public

    public static let defaultValue: SheetBorder = .init(
        color: .clear,
        width: 0,
        radius: 16
    )

    public var color: Color
    public var width: CGFloat
    public var radius: CGFloat
}
