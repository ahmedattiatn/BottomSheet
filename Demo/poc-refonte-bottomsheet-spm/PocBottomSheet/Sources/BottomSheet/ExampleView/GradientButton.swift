//
//  GradientButton.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 22/08/2025.
//
import SwiftUI

// MARK: - GradientButton

struct GradientButton: View {
    // MARK: Internal

    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isPressed = false
                }
                action()
            }
        }) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.vertical, 14)
                .padding(.horizontal, 30)
                .background(
                    LinearGradient(
                        colors: [Color.purple, Color.blue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(20)
                .shadow(
                    color: Color.black.opacity(0.25),
                    radius: 8, x: 0, y: 4
                )
                .scaleEffect(isPressed ? 0.95 : 1)
        }
    }

    // MARK: Private

    @State private var isPressed = false
}
