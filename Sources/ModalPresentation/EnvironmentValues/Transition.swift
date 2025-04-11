import SwiftUI

extension EnvironmentValues {
    private struct TransitionKey: EnvironmentKey {
        static var defaultValue: AnyTransition = .move(edge: .bottom)
    }
    var modalTransition: AnyTransition {
        get { self[TransitionKey.self] }
        set { self[TransitionKey.self] = newValue }
    }
}

extension View {
    public func modalPresentation(transition: AnyTransition) -> some View {
        environment(\.modalTransition, transition)
    }
}
