import SwiftUI

extension EnvironmentValues {
    private struct ModalPresentationCornerRadiusKey: EnvironmentKey {
        static var defaultValue: CGFloat = 18
    }
    var modalPresentationCornerRadius: CGFloat {
        get { self[ModalPresentationCornerRadiusKey.self] }
        set { self[ModalPresentationCornerRadiusKey.self] = newValue }
    }
}
