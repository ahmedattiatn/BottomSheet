//
//  ExampleView+SheetContent.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 22/08/2025.
//
import SwiftUI

extension ExampleView {
    func sheetContent() -> some View {
        VStack(spacing: 20) {
            Text("BottomSheet")
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.green, Color.green, Color.black],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .padding(.top, 10)
                .multilineTextAlignment(.center)
            GradientButton(title: "Close") {
                show = false
            }
            Spacer(minLength: 100)
        }
        .padding(.bottom, 20)
        .frame(maxWidth: .infinity)
    }
}
