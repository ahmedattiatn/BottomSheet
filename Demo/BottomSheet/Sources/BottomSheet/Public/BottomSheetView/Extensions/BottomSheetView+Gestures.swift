//
//  BottomSheetView+Gestures.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 22/08/2025.
//

import SwiftUI

public extension BottomSheetView {
    // MARK: - Gesture Handlers

    /// Adds an action to perform when the drag gesture updates.
    ///
    /// - Parameter action: A closure that receives the current `DragGesture.Value`
    ///   and the inferred `SheetDragDirection`.
    /// - Returns: A copy of the view with the action applied.
    func onDragChange(perform action: @escaping (DragGesture.Value, SheetDragDirection) -> Void) -> Self {
        var copy = self
        copy.onDragChange = action
        return copy
    }

    /// Adds an action to perform when the drag gesture ends.
    ///
    /// - Parameter action: A closure that receives the final `DragGesture.Value`.
    /// - Returns: A copy of the view with the action applied.
    func onDragEnd(perform action: @escaping (DragGesture.Value) -> Void) -> Self {
        var copy = self
        copy.onDragEnd = action
        return copy
    }

    /// Adds an action to perform when the sheet’s indicator is tapped.
    ///
    /// - Parameter action: A closure to execute when the indicator is tapped.
    /// - Returns: A copy of the view with the action applied.
    func onIndicatorTap(perform action: @escaping () -> Void) -> Self {
        var copy = self
        copy.onIndicatorTap = action
        return copy
    }
}
