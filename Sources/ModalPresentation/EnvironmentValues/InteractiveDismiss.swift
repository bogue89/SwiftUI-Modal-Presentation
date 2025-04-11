import SwiftUI

extension EnvironmentValues {
    private struct InteractiveDismissKey: EnvironmentKey {
        static var defaultValue = true
    }
    var modalInteractiveDismiss: Bool {
        get { self[InteractiveDismissKey.self] }
        set { self[InteractiveDismissKey.self] = newValue }
    }
}

extension View {
    public func modalPresentation(interactiveDismissDisabled: Bool) -> some View {
        environment(\.modalInteractiveDismiss, !interactiveDismissDisabled)
    }
}
