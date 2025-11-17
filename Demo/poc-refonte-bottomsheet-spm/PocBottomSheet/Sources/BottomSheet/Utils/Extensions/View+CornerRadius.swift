//
//  View+CornerRadius.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 20/08/2025.
//

import SwiftUI

// MARK: - RoundedCorner

/// A shape that rounds specific corners with a given radius.
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    /// Applies rounded corners only to specified edges.
    func cornerRadius(
        lineWidth: CGFloat,
        borderColor: Color,
        radius: CGFloat,
        corners: UIRectCorner
    ) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
            .overlay(
                RoundedCorner(radius: radius, corners: corners)
                    .stroke(borderColor, lineWidth: lineWidth)
            )
    }
}
