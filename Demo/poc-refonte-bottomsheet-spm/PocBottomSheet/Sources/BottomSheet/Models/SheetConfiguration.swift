//
//  SheetConfiguration.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 18/08/2025.
//

import SwiftUI

// MARK: - SheetConfiguration

/// Combines both visual style (`SheetStyle`) and behavior (`SheetBehavior`)
/// into a single configuration object for a custom bottom sheet.
public struct SheetConfiguration: Equatable, Identifiable {
    // MARK: Lifecycle

    /// Creates a new `SheetConfiguration` instance.
    ///
    /// - Parameters:
    ///   - style: Visual styling of the sheet (shadow, border, background, etc.).
    ///   - behavior: Behavior settings of the sheet (dragging, detents). Defaults to `.defaultValue`.
    ///               Includes the `width` property: configurable width (`SheetWidth`).
    ///               Defaults to `.relative(1)`, which uses the full available width minus safe area insets.
    public init(
        style: SheetStyle = .defaultValue,
        behavior: SheetBehavior = .defaultValue
    ) {
        self.style = style
        self.behavior = behavior
    }

    // MARK: Public

    /// Visual styling of the sheet (appearance-related).
    public var style: SheetStyle

    /// Behavioral configuration of the sheet (interaction-related).
    public var behavior: SheetBehavior

    /// Unique identifier for this configuration instance.
    public let id = UUID()
}
