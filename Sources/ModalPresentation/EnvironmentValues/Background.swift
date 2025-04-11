import SwiftUI

extension EnvironmentValues {
    private struct BackgroundKey: EnvironmentKey {
        static var defaultValue: AnyShapeStyle = .init(.regularMaterial)
    }
    var modalBackground: AnyShapeStyle {
        get { self[BackgroundKey.self] }
        set { self[BackgroundKey.self] = newValue }
    }
}

extension View {
    public func modalPresentation(background: AnyShapeStyle) -> some View {
        environment(\.modalBackground, background)
    }
}
