//
//  ExampleView.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 05/08/2025.
//

import SwiftUI

// MARK: - ExampleView

struct ExampleView: View {
    @State var config: SheetConfiguration = .init(
        style: .init(background: .blue.opacity(0.4)),
        behavior: .init(
            detents: .init(
                values: [.absolute(200), .relative(0.7), .relative(1)]
            )
        )
    )
    @State var contentSize: CGSize = .init(width: 300, height: 550)
    @State var show = true

    var body: some View {
        ZStack {
            MultiWaveBackground().ignoresSafeArea()
            menuView()
            BottomSheetView(
                isPresented: $show,
                configuration: $config,
            ) {
                sheetContent()
                    .frame( //  Adding this frame for testing purposes only
                        width: contentSize.width,
                        height: contentSize.height
                    )
            }
            .onDragChange { value in
                print("Dragging: \(value.translation.height)")
            }
            .onDragEnd { value in
                print("Drag ended at: \(value.location)")
            }
            .onIndicatorTap {
                print("onIndicatorTap: ")
            }
        }
    }
}

#Preview {
    ExampleView()
}
