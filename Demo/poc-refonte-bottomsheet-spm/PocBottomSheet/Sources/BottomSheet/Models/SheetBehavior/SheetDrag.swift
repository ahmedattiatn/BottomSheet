//
//  SheetDrag.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 01/09/2025.
//

import Foundation

// MARK: - SheetDrag

public struct SheetDrag: Equatable {
    // MARK: Lifecycle

    public init(
        allowsDragFromBottomSafeArea: Bool,
        isEnabled: Bool,
        minSnapPercent: CGFloat

    ) {
        self.allowsDragFromBottomSafeArea = allowsDragFromBottomSafeArea
        self.isEnabled = isEnabled
        self.minSnapPercent = min(minSnapPercent, 0.5)
    }

    // MARK: Public

    public static let defaultValue: SheetDrag = .init(
        allowsDragFromBottomSafeArea: false,
        isEnabled: true,
        minSnapPercent: 0.10
    )

    /// Whether dragging from the bottom safe area is allowed.
    public let allowsDragFromBottomSafeArea: Bool

    /// Whether sheet dragging is enabled.
    public var isEnabled: Bool

    /// The minimum snap height as a percentage of the available height (0–0.5).
    public let minSnapPercent: CGFloat
}
