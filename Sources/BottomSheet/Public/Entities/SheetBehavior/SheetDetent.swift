//
//  SheetDetent.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 25/08/2025.
//

import SwiftUI

// MARK: - SheetDetent

/// Represents a collection of detents and the currently active one.
/// Provides convenience properties to get the next or previous detent safely,
/// which is useful for snapping behavior in a BottomSheet.
public struct SheetDetent: Equatable {
    // MARK: Lifecycle

    /// Creates a new `SheetDetent`.
    ///
    /// - Parameters:
    ///   - values: The detents to use. Must not be empty. Duplicate values are removed and the list is sorted.
    ///   - current: The currently active detent. If `nil` or not included in `values`,
    ///              the first sorted detent is used instead.
    public init(values: [SheetDetentHeight], current: SheetDetentHeight? = nil) {
        let uniqueValues = Array(Set(values.isEmpty ? [.relative(1)] : values)).sorted()
        self.values = uniqueValues
        self.current = if let current, uniqueValues.contains(current) {
            current
        } else {
            uniqueValues.first ?? .relative(1)
        }
    }

    // MARK: Public

    /// The default `SheetDetent` configuration with two stops:
    /// - An absolute height of **120 points**
    /// - A full-height relative detent (`1.0` = screen’s available height)
    public static let defaultValue = SheetDetent(
        values: [.absolute(120), .relative(1)]
    )

    /// The list of all detents for this sheet.
    public private(set) var values: [SheetDetentHeight]

    /// The currently active detent.
    public private(set) var current: SheetDetentHeight
}

// MARK: - SheetDetent Convenience Properties

public extension SheetDetent {
    /// Returns `true` if the current detent is the last in the list.
    var isCurrentLast: Bool { values.last == current }

    /// Returns `true` if the current detent is the first in the list.
    var isCurrentFirst: Bool { values.first == current }

    /// Returns the next detent after the current one, or the current if already at the last.
    ///
    /// Safe: will not go out of bounds even if the current detent is missing from `values`.
    var next: SheetDetentHeight {
        guard let currentIndex = values.firstIndex(where: { $0 == current }) else {
            return current
        }
        let nextIndex = min(currentIndex + 1, values.count - 1)
        return values[nextIndex]
    }

    /// Returns the previous detent before the current one, or the current if already at the first.
    ///
    /// Safe: will not go out of bounds even if the current detent is missing from `values`.
    var previous: SheetDetentHeight {
        guard let currentIndex = values.firstIndex(where: { $0 == current }) else {
            return current
        }
        let prevIndex = max(currentIndex - 1, 0)
        return values[prevIndex]
    }

    /// Updates the currently active detent to the specified value.
    ///
    /// If the provided detent exists in the `values` list, it becomes the new current detent.
    /// If the detent is not in the list, this call is ignored and the current detent remains unchanged.
    ///
    /// - Parameter current: The `SheetDetentHeight` to set as the active detent.
    mutating func update(current: SheetDetentHeight) {
        if values.contains(current), self.current != current {
            self.current = current
        }
    }
}
