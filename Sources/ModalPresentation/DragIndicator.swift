import SwiftUI

public enum DragIndicatorSize {
    case regular
    case large
}

struct DragIndicator: View {
    @Environment(\.dragIndicatorSize) var dragIndicatorSize

    var body: some View {
        Capsule()
            .frame(
                width: dragIndicatorSize == .regular ? 36 : 10,
                height: dragIndicatorSize == .regular ? 6 : 8
            )
            .background(.thinMaterial)
    }
}

extension EnvironmentValues {
    private struct DragIndicatorSizeKey: EnvironmentKey {
        static var defaultValue: DragIndicatorSize = .regular
    }
    public var dragIndicatorSize: DragIndicatorSize {
        get { self[DragIndicatorSizeKey.self] }
        set { self[DragIndicatorSizeKey.self] = newValue }
    }
}

#Preview {
    DragIndicator()
}
