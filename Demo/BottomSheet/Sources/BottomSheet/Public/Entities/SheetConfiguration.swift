//
//  SheetConfiguration.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 18/08/2025.
//

import SwiftUI

// MARK: - SheetConfiguration

/// Combines visual style (`SheetStyle`), behavior (`SheetBehavior`),
/// and animation (`SheetAnimation`) into a single configuration object
/// for a custom bottom sheet.
///
/// This struct allows you to fully configure the bottom sheet's appearance,
/// interaction behavior, and which changes should trigger animations.
public struct SheetConfiguration: Equatable, Identifiable {
    // MARK: Lifecycle

    /// Creates a new `SheetConfiguration` instance.
    ///
    /// - Parameters:
    ///   - style: Visual styling of the sheet (shadow, border, background, etc.).
    ///            Defaults to `.defaultValue`.
    ///   - behavior: Behavior settings of the sheet (dragging, detents, alignment, width).
    ///               Defaults to `.defaultValue`.
    ///   - animation: Animation settings for the sheet, including which keys
    ///                trigger animations when changed. Defaults to `.defaultValue`.
    public init(
        style: SheetStyle = .defaultValue,
        behavior: SheetBehavior = .defaultValue,
        animation: SheetAnimation = .defaultValue
    ) {
        self.style = style
        self.behavior = behavior
        self.animation = animation
    }

    // MARK: Public

    /// Visual styling of the sheet (appearance-related).
    public var style: SheetStyle

    /// Behavioral configuration of the sheet (interaction-related).
    public var behavior: SheetBehavior

    /// Animation settings for presenting, dismissing, and updating the sheet.
    public var animation: SheetAnimation

    /// Unique identifier for this configuration instance.
    public let id = UUID()
}
