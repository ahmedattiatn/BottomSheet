//
//  SheetAlignment.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 21/08/2025.
//

import SwiftUI

/// Defines alignment options for a bottom sheet.
public enum SheetBottomAlignment: String, Equatable {
    case center
    case leading
    case trailing

    // MARK: Internal

    /// Converts `SheetBottomAlignment` to SwiftUI's `Alignment`.
    var value: Alignment {
        switch self {
        case .center: return .bottom
        case .leading: return .bottomLeading
        case .trailing: return .bottomTrailing
        }
    }
}
