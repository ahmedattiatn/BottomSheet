//
//  MultiWaveBackground.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 22/08/2025.
//

import SwiftUI

// MARK: - MultiWaveBackground

struct MultiWaveBackground: View {
    // MARK: Internal

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(
                    colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                ForEach(Array(layers.enumerated()), id: \.offset) { index, layer in
                    WaveShape(
                        phase: phase * (1 - CGFloat(index) * 0.2),
                        amplitude: layer.amplitude,
                        frequency: layer.frequency
                    )
                    .foregroundColor(Color.white.opacity(layer.opacity))
                    .frame(height: geometry.size.height)
                }
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1 / 60, repeats: true) { _ in
                    phase += 0.03
                    if phase > .pi * 2 {
                        phase -= .pi * 2
                    }
                }
            }
        }
    }

    // MARK: Private

    @State private var phase: CGFloat = 0

    private let layers: [
        (amplitude: CGFloat,
         frequency: CGFloat,
         opacity: Double)
    ]
        = [
            (20, 2, 0.3),
            (30, 1.5, 0.2)
        ]
}

// MARK: - WaveShape

struct WaveShape: Shape {
    var phase: CGFloat
    var amplitude: CGFloat
    var frequency: CGFloat

    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let midY = rect.midY

        path.move(to: CGPoint(x: 0, y: midY))
        for x in stride(from: 0, through: width, by: 6) {
            let relativeX = x / width
            let y = amplitude * sin(relativeX * frequency * 2 * .pi + phase) + midY
            path.addLine(to: CGPoint(x: x, y: y))
        }

        path.addLine(to: CGPoint(x: width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()

        return path
    }
}
