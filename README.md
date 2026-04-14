# ModalPresentation

A SwiftUI library for presenting customizable bottom-sheet modals with drag-to-resize, snap-to-detent positioning, and flexible appearance configuration.

**Requirements:** iOS 17+ · Swift 5.9+

---

## Installation

### Swift Package Manager

In Xcode, go to **File → Add Package Dependencies** and enter the repository URL:

```
https://github.com/bogue89/ModalPresentation
```

Or add it directly to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/bogue89/ModalPresentation", from: "1.0.0")
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["ModalPresentation"]
    )
]
```

---

## Usage

### Basic modal

```swift
import ModalPresentation

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        Button("Show Modal") { isPresented = true }
            .modal($isPresented) {
                Text("Hello from the modal!")
                    .padding()
            }
    }
}
```

### Resizable modal with detents

```swift
struct ContentView: View {
    @State private var isPresented = false
    @State private var detent: ModalDetent = .medium

    var body: some View {
        Button("Show Modal") { isPresented = true }
            .modal($isPresented, modalDetent: $detent, detents: [.small, .medium, .large]) {
                MySheetContent()
            }
    }
}
```

### Customizing appearance

Chain `.modalPresentation(...)` modifiers to adjust the look and behavior:

```swift
.modal($isPresented) {
    MySheetContent()
}
.modalPresentation(background: .thinMaterial)
.modalPresentation(cornerRadius: 24)
.modalPresentation(backdrop: Color.black.opacity(0.4))
.modalPresentation(interactiveDismissDisabled: true)
```

---

## Detents

`ModalDetent` controls the height of the modal:

| Detent | Height |
|---|---|
| `.small` | 25% of screen |
| `.medium` | 60% of screen |
| `.large` | 90% of screen |
| `.fullscreen` | 100% of screen |
| `.fraction(0.45)` | Custom fraction |
| `.height(300)` | Fixed point height |

---

## License

MIT
