import SwiftUI

extension EnvironmentValues {
    private struct CornerRadiusKey: EnvironmentKey {
        static var defaultValue: CGFloat = 18
    }
    var modalCornerRadius: CGFloat {
        get { self[CornerRadiusKey.self] }
        set { self[CornerRadiusKey.self] = newValue }
    }
}

extension View {
    public func modalPresentation(cornerRadius: CGFloat) -> some View {
        environment(\.modalCornerRadius, cornerRadius)
    }
}
