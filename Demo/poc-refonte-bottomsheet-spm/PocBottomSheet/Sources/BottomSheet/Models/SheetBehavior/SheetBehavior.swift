//
//  SheetBehavior.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 03/09/2025.
//

import Foundation

/// Defines the **interaction behavior** of the bottom sheet.
public struct SheetBehavior: Equatable {
    // MARK: Lifecycle

    /// Creates a new `SheetBehavior` instance.
    ///
    /// - Parameters:
    ///   - drag: Drag behavior configuration. Defaults to `.defaultValue`.
    ///   - width: Configurable width of the sheet. Defaults to `.relative(1)`.
    ///   - detents: Allowed snap points for the sheet. Each detent is a `SheetDetentHeight` (absolute or relative).
    ///   - alignment: Alignment of the sheet along the bottom of the screen. Defaults to `.leading`.
    public init(
        drag: SheetDrag = .defaultValue,
        width: SheetWidth = .relative(1),
        detents: SheetDetent = .defaultValue,
        alignment: SheetBottomAlignment = .leading
    ) {
        self.drag = drag
        self.width = width
        self.detents = detents
        self.alignment = alignment
    }

    // MARK: Public

    public static let defaultValue: SheetBehavior = .init()

    // MARK: Interaction

    /// Drag behavior configuration, controlling user interaction and snapping behavior.
    public var drag: SheetDrag

    // MARK: Layout

    /// Configurable width of the sheet.
    /// - `.relative(CGFloat)`: Fraction of the available width after safe area insets.
    /// - `.absolute(CGFloat)`: Fixed width in points.
    public var width: SheetWidth

    /// Allowed snap points for the sheet. Each detent is a `SheetDetentHeight` (absolute or relative).
    public var detents: SheetDetent

    /// Alignment of the sheet along the bottom of the screen.
    public var alignment: SheetBottomAlignment
}
