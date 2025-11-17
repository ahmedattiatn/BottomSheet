//
//  SheetDetent.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 25/08/2025.
//

import SwiftUI

// MARK: - SheetDetent

/// Represents a collection of detents and the currently active one.
public struct SheetDetent: Equatable {
    // MARK: Lifecycle

    /// Creates a new `SheetDetent`.
    ///
    /// - Parameters:
    ///   - values: The detents to use. Must not be empty.
    ///   - current: The currently active detent. If `nil` or not included in `values`,
    ///              the first sorted detent is used instead.
    public init(values: [SheetDetentHeight], current: SheetDetentHeight? = nil) {
        precondition(!values.isEmpty, "SheetDetent must have at least one detent.")
        self.values = Array(Set(values)).sorted()
        self.current = if let current, self.values.contains(current) {
            current
        } else {
            self.values.first ?? .relative(1)
        }
    }

    // MARK: Public

    public static let defaultValue = SheetDetent(
        values: [.relative(0.5), .relative(1)]
    )

    public var values: [SheetDetentHeight]
    public var current: SheetDetentHeight
}
