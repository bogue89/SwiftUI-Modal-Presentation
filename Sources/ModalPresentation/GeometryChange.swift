import SwiftUI

public struct GeometryChange: ViewModifier {
    let didGeometryChange: (GeometryProxy) -> Void

    public func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { proxy in
                    DispatchQueue.main.async {
                        didGeometryChange(proxy)
                    }
                    return Color.clear
                }
            }
    }
}

extension View {
    public func onGeometryChange(perform: @escaping (GeometryProxy) -> Void) -> ModifiedContent<Self, GeometryChange> {
        modifier(GeometryChange(didGeometryChange: perform))
    }
}
