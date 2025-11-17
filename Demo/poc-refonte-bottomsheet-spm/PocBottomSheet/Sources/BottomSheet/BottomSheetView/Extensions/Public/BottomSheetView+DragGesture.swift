//
//  BottomSheetView+DragGesture.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 22/08/2025.
//

import SwiftUI

public extension BottomSheetView {
    /// Sets an action to perform when the drag gesture’s value changes.
    ///
    /// - Parameter action: The closure to execute when the drag changes.
    /// - Returns: A copy of the view with the action applied.
    func onDragChange(_ action: @escaping (DragGesture.Value) -> Void) -> Self {
        var copy = self
        copy.onDragChange = action
        return copy
    }

    /// Sets an action to perform when the drag gesture ends.
    ///
    /// - Parameter action: The closure to execute when the drag ends.
    /// - Returns: A copy of the view with the action applied.
    func onDragEnd(_ action: @escaping (DragGesture.Value) -> Void) -> Self {
        var copy = self
        copy.onDragEnd = action
        return copy
    }

    /// Sets an action to perform when the indicator is tapped.
    ///
    /// - Parameter action: The closure to execute when the indicator is tapped.
    /// - Returns: A copy of the view with the action applied.
    func onIndicatorTap(_ action: @escaping () -> Void) -> Self {
        var copy = self
        copy.onIndicatorTap = action
        return copy
    }
}
