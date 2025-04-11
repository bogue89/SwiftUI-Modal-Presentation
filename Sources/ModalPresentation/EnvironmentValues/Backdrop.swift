import SwiftUI

extension EnvironmentValues {
    private struct BackdropKey: EnvironmentKey {
        static var defaultValue: AnyShapeStyle = .init(.black.opacity(0.2))
    }
    var modalBackdrop: AnyShapeStyle {
        get { self[BackdropKey.self] }
        set { self[BackdropKey.self] = newValue }
    }
}

extension View {
    public func modalPresentation(backdrop: AnyShapeStyle) -> some View {
        environment(\.modalBackdrop, backdrop)
    }
}
