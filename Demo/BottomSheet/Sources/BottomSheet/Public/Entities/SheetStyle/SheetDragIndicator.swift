//
//  SheetDragIndicator.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 18/08/2025.
//
import SwiftUI

// MARK: - SheetDragIndicator

/// Represents the visual drag indicator for a bottom sheet,
/// including size, color, padding, and whether it is enabled.
///
/// Typically displayed at the top of the sheet to hint to users that
/// it can be dragged.
public struct SheetDragIndicator: Equatable {
    // MARK: Lifecycle

    /// Creates a new `SheetDragIndicator` with the specified properties.
    ///
    /// - Parameters:
    ///   - height: Height of the drag indicator. Defaults to `defaultValue.height`.
    ///   - width: Width of the drag indicator. Defaults to `defaultValue.width`.
    ///   - color: Color of the drag indicator. Defaults to `defaultValue.color`.
    ///   - padding: Padding around the indicator. Defaults to `defaultValue.padding`.
    ///   - isEnabled: Determines if the indicator is visible and interactive. Defaults to `defaultValue.isEnabled`.
    public init(
        height: CGFloat = defaultValue.height,
        width: CGFloat = defaultValue.width,
        color: Color = defaultValue.color,
        padding: EdgeInsets = defaultValue.padding,
        isEnabled: Bool = defaultValue.isEnabled
    ) {
        self.height = height
        self.width = width
        self.color = color
        self.padding = padding
        self.isEnabled = isEnabled
    }

    // MARK: Public

    /// Default drag indicator configuration.
    public static let defaultValue: SheetDragIndicator = .init(
        height: 5,
        width: 36,
        color: Color.secondary,
        padding: .init(top: 8, leading: 8, bottom: 8, trailing: 8),
        isEnabled: true
    )

    /// Height of the drag indicator.
    public let height: CGFloat
    /// Width of the drag indicator.
    public let width: CGFloat
    /// Color of the drag indicator.
    public var color: Color
    /// Padding around the drag indicator.
    public let padding: EdgeInsets
    /// Determines whether the drag indicator is enabled.
    public var isEnabled: Bool
}
