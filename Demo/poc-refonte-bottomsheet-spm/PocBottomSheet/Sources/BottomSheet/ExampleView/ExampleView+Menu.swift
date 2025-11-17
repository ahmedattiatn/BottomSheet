//
//  Example+Menu.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 22/08/2025.
//

import SwiftUI

extension ExampleView {
    func menuView() -> some View {
        VStack(spacing: 20) {
            Text("Hello, SwiftUI!")
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.black, Color.green],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .padding(.top, 10)
                .multilineTextAlignment(.center)
                .padding(.top, 40)

            GradientButton(
                title: show
                    ? "Hide BottomSheet"
                    : "Show BottomSheet"
            ) {
                show.toggle()
            }
            GradientButton(
                title: "Toggle Alignment (\(config.behavior.alignment.rawValue.capitalized))"
            ) {
                updateAlignment()
            }
        }
        .padding()
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
    }

    private func updateAlignment() {
        config.behavior.alignment = switch config.behavior.alignment {
        case .leading: .center
        case .trailing: .leading
        case .center: .trailing
        }
    }
}
