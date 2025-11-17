//
//  SheetAnimationKey.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 12/09/2025.
//

public enum SheetAnimationKey: Hashable, CaseIterable {
    case width
    case detents
    case alignment
    case background
    case padding

    // MARK: Public

    /// Convenience set that includes all keys except `.padding` and `.width`.
    ///
    /// Use this set to disable animations for padding and width changes,
    /// while still animating other configuration updates.
    /// In cases where you want to animate those excluded properties,
    /// with the animation of the bottom sheet defined in `SheetAnimationType`,
    /// you can just use SwiftUI's default `withAnimation` directly from your UI
    /// without passing a specific animation type.
    public static let defaultValue: Set<SheetAnimationKey> =
        Set(Self.allCases.filter { $0 != .padding && $0 != .width })
}
