//
//  SheetAnimation.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 12/09/2025.
//

import SwiftUI

/// Defines the animation behavior for a bottom sheet.
public struct SheetAnimation: Equatable {
    // MARK: Lifecycle

    /// Creates a new `SheetAnimation` instance.
    ///
    /// - Parameters:
    ///   - value: The animation to use when presenting or dismissing the sheet.
    ///            Defaults to `.defaultValue`.
    ///   - animatedKeys: The set of `SheetAnimationKey` values that should
    ///                   trigger animations when their corresponding configuration
    ///                   properties change. Defaults to `SheetAnimationKey.defaultValue`.
    public init(type: SheetAnimationType = .defaultValue,
                animatedKeys: Set<SheetAnimationKey> = SheetAnimationKey.defaultValue) {
        self.value = type.value
        self.animatedKeys = animatedKeys
    }

    // MARK: Public

    /// Default animation for bottom sheets.
    public static let defaultValue: SheetAnimation = .init(
        type: .defaultValue,
        animatedKeys: SheetAnimationKey.defaultValue
    )

    /// The animation used for presenting or dismissing the sheet.
    public var value: Animation

    /// The keys that should trigger animations when configuration changes.
    ///
    /// Only the properties corresponding to the keys included in this set
    /// will cause SwiftUI to animate the sheet when they change.
    public var animatedKeys: Set<SheetAnimationKey>
}
