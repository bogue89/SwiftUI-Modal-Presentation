import SwiftUI

extension EnvironmentValues {
    private struct ModalPresentationBackgroundKey: EnvironmentKey {
        static var defaultValue: AnyShapeStyle = .init(.regularMaterial)
    }
    var modalPresentationBackground: AnyShapeStyle {
        get { self[ModalPresentationBackgroundKey.self] }
        set { self[ModalPresentationBackgroundKey.self] = newValue }
    }
}

extension View {
    public func modalPresentation(background: AnyShapeStyle) -> some View {
        environment(\.modalPresentationBackground, background)
    }
}
