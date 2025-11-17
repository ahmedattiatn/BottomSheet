# 🛷 BottomSheetView

`BottomSheetView` is a **flexible SwiftUI bottom sheet component** that supports drag gestures, dynamic heights, safe area adjustments, and smooth animations. Perfect for modern iOS interfaces.

---


<img src="https://github.com/ahmedattiatn/BottomSheet/blob/main/Docs/Images/1.png?raw=true" width="700">




---

## ✨ Features

- 📐 **Dynamic height** based on detents.
- ✋ **Drag gestures** with optional callbacks for drag changes and drag end events.
- 🎨 **Customizable appearance**: background, shadow, border, and corner radius.
- ⌨️ **Keyboard & safe area support** for smooth presentation.
- ⚡ **Animations** for seamless transitions between states.

---

## 🛠 Installation

Add `BottomSheetView` to your SwiftUI project.  
No external dependencies required.

---

## 🚀 Basic Usage
Integrate with MultiWaveBackground for a beautiful animated backdrop:

```swift
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
```

---

## 📚 API Reference

### `BottomSheetView`

- `isPresented: Binding<Bool>` – Controls sheet visibility.
- `configuration: Binding<SheetConfiguration>` – Sheet appearance & behavior.
- `content: () -> Content` – ViewBuilder for sheet content.

### Callbacks

- `.onDragChange { DragGesture.Value -> Void }` – Called **while dragging**.
- `.onDragEnd { DragGesture.Value -> Void }` – Called **when drag ends**.
- `.onIndicatorTap { DragGesture.Value -> Void }` – Called **when Indicator Tapped**.
---

## 📌 Notes
- Requires **iOS 16+** and SwiftUI.
- Built for **lightweight integration** with zero external dependencies.

---



