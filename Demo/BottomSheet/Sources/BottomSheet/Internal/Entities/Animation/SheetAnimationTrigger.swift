//
//  SheetAnimationTrigger.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 12/09/2025.
//

// MARK: - SheetAnimationTrigger

import Foundation

/// A lightweight value type used as the animation key for bottom sheets.
///
/// SwiftUI triggers animations when the value passed to `.animation(value:)`
/// changes according to `Equatable`. `SheetAnimationTrigger` wraps the relevant
/// sheet state and configuration, allowing fine-grained control over which
/// changes should animate.
///
/// Components:
/// - `configuration`: The current `SheetConfiguration` (style, behavior, etc.).
/// - `translation`: The drag offset of the sheet; animations respond to changes.
/// - `isPresented`: Whether the sheet is currently presented. Toggling this animates the sheet.
/// - `animatedKeys`: The set of `SheetAnimationKey` values that determine which
///   configuration changes trigger an animation. Keys not included in this set
///   are ignored for animation purposes.
struct SheetAnimationTrigger: Equatable, Identifiable {
    /// The current configuration of the bottom sheet.
    let configuration: SheetConfiguration

    /// The current drag offset of the sheet.
    let translation: CGFloat

    /// Whether the sheet is currently presented.
    let isPresented: Bool

    /// The set of configuration keys that should trigger animations.
    let animatedKeys: Set<SheetAnimationKey>

    /// Unique identifier for this trigger.
    let id = UUID()

    // MARK: Equatable

    static func == (lhs: SheetAnimationTrigger, rhs: SheetAnimationTrigger) -> Bool {
        // Always animate if translation or presentation state changes
        guard lhs.translation == rhs.translation,
              lhs.isPresented == rhs.isPresented else {
            return false
        }

        // Only compare configuration keys that are included in animatedKeys
        if lhs.animatedKeys.contains(.detents),
           lhs.configuration.behavior.detents != rhs.configuration.behavior.detents {
            return false
        }

        if lhs.animatedKeys.contains(.alignment),
           lhs.configuration.behavior.alignment != rhs.configuration.behavior.alignment {
            return false
        }

        if lhs.animatedKeys.contains(.width),
           lhs.configuration.behavior.width != rhs.configuration.behavior.width {
            return false
        }

        if lhs.animatedKeys.contains(.background),
           lhs.configuration.style.background != rhs.configuration.style.background {
            return false
        }

        if lhs.animatedKeys.contains(.padding),
           lhs.configuration.style.padding != rhs.configuration.style.padding {
            return false
        }

        return true
    }
}
