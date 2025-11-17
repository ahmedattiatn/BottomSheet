//
//  SheetAnimationType.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 21/08/2025.
//

import SwiftUI

// MARK: - SheetAnimationType

public enum SheetAnimationType: Equatable {
    case curve
    case spring
    case smooth

    // MARK: Public

    public static let defaultValue: SheetAnimationType = .spring

    // MARK: Internal

    var value: Animation {
        return switch self {
        case .curve:
            .interpolatingSpring(
                // The mass of the object attached to the spring.
                mass: 1.2,
                // The stiffness of the spring   higher = faster spring, shorter cycle.
                stiffness: 180,
                // lower = more overshoot higher = less bounce.
                damping: 27
            )

        case .spring:
            .spring(
                response: 0.5, // speed of the spring: smaller = faster, larger = slower
                dampingFraction: 0.75, // for smooth settling, <1 to keep some bounce
                blendDuration: 1.0 // Smoothly blends to new animations if value changes
            )

        case .smooth:
            .interpolatingSpring(
                mass: 1.2,
                stiffness: 140,
                damping: 35
            )
        }
    }
}
