//
//  SheetDrag.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 01/09/2025.
//

// MARK: - SheetDrag

import Foundation

/// Configuration for drag behavior of a bottom sheet.
///
/// This struct controls how the sheet reacts to user drags, including snapping thresholds,
/// drag resistance, velocity thresholds for fast flicks, and momentum projection for smooth snapping.
public struct SheetDrag: Equatable {
    // MARK: Lifecycle

    /// Creates a new `SheetDrag` configuration.
    ///
    /// - Parameters:
    ///   - allowsDragFromBottomSafeArea: Whether dragging from the bottom safe area is allowed.
    ///   - isEnabled: Whether dragging is enabled.
    ///   - minimumDistance: Minimum drag distance (in points) before the gesture is recognized. (Clamped 0…200)
    ///   - minSnapPercent: Minimum fraction of sheet height required to trigger a snap for slow drags. (Clamped 0…0.5)
    ///   - velocityThreshold: Minimum drag velocity (points/sec) considered a "fast flick". (Clamped 0…1000)
    ///   - resistance: Drag resistance applied at first/last detent boundaries (0 = full resistance, 1 = no resistance).
    public init(
        allowsDragFromBottomSafeArea: Bool,
        isEnabled: Bool,
        minimumDistance: CGFloat,
        minSnapPercent: CGFloat,
        velocityThreshold: CGFloat,
        resistance: CGFloat
    ) {
        self.allowsDragFromBottomSafeArea = allowsDragFromBottomSafeArea
        self.isEnabled = isEnabled
        self.minimumDistance = min(max(minimumDistance, 0), 200)
        self.minSnapPercent = min(max(minSnapPercent, 0), 0.5)
        self.velocityThreshold = min(max(velocityThreshold, 0), 1000)
        self.resistance = min(max(resistance, 0), 1)
    }

    // MARK: Public

    /// Default drag configuration.
    ///
    /// - `allowsDragFromBottomSafeArea`: false → dragging from bottom safe area is disabled by default.
    /// - `isEnabled`: true → dragging is enabled.
    /// - `minimumDistance`: 25 → finger must move 25 pts before drag gesture is recognized.
    /// - `minSnapPercent`: 0.1 → once dragging, sheet must move at least 10% of its height to snap.
    /// - `velocityThreshold`: 500 → a flick faster than 500 pts/sec will snap immediately to the next/previous detent.
    /// - `resistance`: 0.2 → slight resistance when dragging beyond first/last detent.
    public static let defaultValue: SheetDrag = .init(
        allowsDragFromBottomSafeArea: false,
        isEnabled: true,
        minimumDistance: 25,
        minSnapPercent: 0.1,
        velocityThreshold: 500,
        resistance: 0.2
    )

    /// Whether dragging from the bottom safe area is allowed.
    public let allowsDragFromBottomSafeArea: Bool

    /// Whether sheet dragging is enabled.
    public var isEnabled: Bool

    /// Minimum drag distance (in points) before the drag gesture is recognized.
    ///
    /// Example: 25 → finger must move 25 pts vertically before sheet starts responding.
    ///
    /// - “Don’t even start moving the couch until I’ve pushed it hard enough.”
    public let minimumDistance: CGFloat

    /// Minimum fraction of sheet height required to snap on slow drags (0…0.5).
    ///
    /// Example: 0.1 → drag must exceed 10% of sheet height to trigger a snap.
    ///
    /// - “Okay, I’ve started moving the couch, but I’ll only slide it all the way
    ///   into the next room if I push it at least 10% of the way.”
    public let minSnapPercent: CGFloat

    /// Minimum velocity (points/sec) to consider a drag a fast flick.
    ///
    /// Drags faster than this threshold snap immediately to the next/previous detent.
    /// Example: 500 → flicks faster than 500 pts/sec trigger immediate snapping.
    public let velocityThreshold: CGFloat

    /// Resistance applied at first/last detent boundaries.
    ///
    /// - 0 → full resistance (hard to drag beyond limits)
    /// - 1 → no resistance (free drag)
    /// - Example: 0.2 → slight resistance at sheet edges.
    public let resistance: CGFloat
}
