//
//  BottomSheetView.swift
//  BottomSheet
//
//  Created by Ahmed Atia on 12/08/2025.
//

import SwiftUI

// MARK: - BottomSheetView

public struct BottomSheetView<Content: View>: View {
    // MARK: Lifecycle

    /// Creates a new `BottomSheetView`.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether the sheet is currently presented.
    ///     Defaults to `true`. Use `isPresented` if you want to dismiss the bottom sheet and then present it again
    ///     with the last detent value before it was dismissed.
    ///   - configuration: A binding to a `SheetConfiguration` object that defines the appearance, behavior, and animation of the sheet.
    ///   - content: A view builder that provides the content of the sheet.
    public init(
        isPresented: Binding<Bool> = .constant(true),
        configuration: Binding<SheetConfiguration>,
        @ViewBuilder content: () -> Content
    ) {
        self._isPresented = isPresented
        self._configuration = configuration
        self.content = content()
    }

    // MARK: Public

    public var body: some View {
        sheetView()
            .ignoresSafeArea(edges: .bottom)
    }

    // MARK: Internal

    @Environment(\.safeAreaInsets) var safeAreaInsets
    @StateObject var viewModel: BottomSheetViewModel = .init()
    @GestureState var translation: CGFloat = 0
    @Binding var configuration: SheetConfiguration
    @State var dragDirection: SheetDragDirection = .none

    var onDragEnd: (DragGesture.Value) -> Void = { _ in }
    var onDragChange: (DragGesture.Value, SheetDragDirection) -> Void = { _, _ in }
    var onIndicatorTap: () -> Void = {}

    var style: SheetStyle { configuration.style }
    var behavior: SheetBehavior { configuration.behavior }
    var animation: SheetAnimation { configuration.animation }

    // MARK: Private

    @Binding private var isPresented: Bool

    private let content: Content

    /// The main sheet view.
    @ViewBuilder
    private func sheetView() -> some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                dragIndicatorView
                content
            }
            // Frame 1: Sheet size (width and height)
            .frame(
                width: behavior.width.toAbsolute(for: geometry.size.width),
                height: isPresented ? sheetHeight(for: geometry.size.height) : 0,
                alignment: .top // Anchor content at top of sheet frame
            )
            .background(style.background)
            .cornerRadius(
                lineWidth: style.border.width,
                borderColor: style.border.color,
                radius: style.border.radius,
                corners: [.topLeft, .topRight]
            )
            .shadow(
                color: style.shadow.color,
                radius: style.shadow.radius,
                x: style.shadow.x,
                y: style.shadow.y
            )
            // Frame 2: Position sheet in parent container
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: behavior.alignment.value // Bottom aligned
            )
            .padding(style.padding)
            .gesture(onVerticalDrag(from: geometry.size.height))
            // Use animation from configuration
            .animation(
                animation.value,
                value: SheetAnimationTrigger(
                    configuration: configuration,
                    translation: translation,
                    isPresented: isPresented,
                    animatedKeys: animation.animatedKeys
                )
            )
        }
    }
}
