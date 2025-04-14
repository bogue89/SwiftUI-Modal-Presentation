import SwiftUI

struct DragIndicator: View {
    @Environment(\.dragIndicatorSize) var dragIndicatorSize
    var body: some View {
        // TODO: Check white clipping outter bounds
        Capsule()
            .frame(
                width: dragIndicatorSize == .regular ? 36 : 40,
                height: dragIndicatorSize == .regular ? 6 : 8
            )
            .background(.thinMaterial)
    }
}

#Preview {
        DragIndicator()
            .environment(\.dragIndicatorSize, .regular)
        DragIndicator()
            .environment(\.dragIndicatorSize, .large)
}
