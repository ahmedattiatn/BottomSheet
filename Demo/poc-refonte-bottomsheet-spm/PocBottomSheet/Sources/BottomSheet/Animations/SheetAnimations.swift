//
//  SheetAnimations.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 21/08/2025.
//

import SwiftUI

// MARK: - SheetAnimations

public enum SheetAnimations: Equatable {
    case curve
    case spring
    case smooth

    // MARK: Public

    public static let defaultValue: SheetAnimations = .smooth

    public var value: Animation {
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
                response: 0.6, // speed of the spring: smaller = faster, larger = slower
                dampingFraction: 0.85, // for smooth settling, <1 to keep some bounce
                blendDuration: 0.8 // Smoothly blends to new animations if value changes
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

// MARK: SheetAnimations.Trigger

extension SheetAnimations {
    // MARK: Internal

    struct Trigger: Equatable, Identifiable {
        let configuration: SheetConfiguration
        let isPresented: Bool
        let id = UUID()

        static func == (lhs: Trigger, rhs: Trigger) -> Bool {
            lhs.configuration == rhs.configuration &&
                lhs.isPresented == rhs.isPresented
        }
    }
}
