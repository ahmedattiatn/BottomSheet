//
//  SheetStyle.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 03/09/2025.
//

import SwiftUI

// MARK: - SheetStyle

/// Defines the **visual styling and layout/interaction** of a bottom sheet.
public struct SheetStyle: Equatable {
    // MARK: Lifecycle

    /// Creates a new `SheetStyle` instance.
    ///
    /// - Parameters:
    ///   - shadow: Shadow styling of the sheet. Defaults to `.defaultValue`.
    ///   - border: Border styling of the sheet. Defaults to `.defaultValue`.
    ///   - background: Background color of the sheet. Defaults to `Color(.secondarySystemBackground)`.
    ///   - padding: Inner padding of the sheet. Defaults to `top: 8, leading: 0, bottom: 0, trailing: 0`.
    ///   - dragIndicator: Drag indicator styling. Defaults to `.defaultValue`.
    public init(
        shadow: SheetShadow = .defaultValue,
        border: SheetBorder = .defaultValue,
        background: Color = Color(.secondarySystemBackground),
        padding: EdgeInsets = .init(top: 8, leading: 0, bottom: 0, trailing: 0),
        dragIndicator: SheetDragIndicator = .defaultValue
    ) {
        self.shadow = shadow
        self.border = border
        self.background = background
        self.padding = padding
        self.dragIndicator = dragIndicator
    }

    // MARK: Public

    public static let defaultValue: SheetStyle = .init()

    // MARK: Visual Appearance

    /// Shadow styling applied to the sheet.
    public let shadow: SheetShadow

    /// Border styling applied to the sheet.
    public var border: SheetBorder

    /// Background color of the sheet.
    public var background: Color

    // MARK: Layout & Interaction

    /// Padding applied inside the sheet.
    public var padding: EdgeInsets

    /// Drag indicator styling for the sheet.
    public var dragIndicator: SheetDragIndicator
}
