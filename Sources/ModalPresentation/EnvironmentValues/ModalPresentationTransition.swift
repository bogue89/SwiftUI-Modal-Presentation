import SwiftUI

extension EnvironmentValues {
    private struct ModalPresentationTransitionKey: EnvironmentKey {
        static var defaultValue: AnyTransition = .move(edge: .bottom)
    }
    var modalPresentationTransition: AnyTransition {
        get { self[ModalPresentationTransitionKey.self] }
        set { self[ModalPresentationTransitionKey.self] = newValue }
    }
}
