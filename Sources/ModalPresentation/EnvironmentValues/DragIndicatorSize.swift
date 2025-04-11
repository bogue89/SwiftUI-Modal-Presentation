import SwiftUI

public enum DragIndicatorSize {
    case regular
    case large
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

extension View {
    public func modalPresentation(dragIndicatorSize: DragIndicatorSize) -> some View {
        environment(\.dragIndicatorSize, dragIndicatorSize)
    }
}
