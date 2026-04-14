import SwiftUI

enum DemoBackground: Identifiable, CaseIterable {
    case clear
    case material
    case solid

    var id: String { .init(describing: self) }
    var value: AnyShapeStyle {
        switch self {
        case .clear: .init(Color.clear)
        case .material: .init(.regularMaterial)
        case .solid: .init(Color.white)
        }
    }
}

enum DemoBackdrop: Identifiable, CaseIterable {
    case clear
    case shade
    case material

    var id: String { .init(describing: self) }
    var value: AnyShapeStyle {
        switch self {
        case .clear: .init(Color.clear)
        case .shade: .init(Color.black.opacity(0.2))
        case .material: .init(.ultraThinMaterial)
        }
    }
}

enum DemoTransition: Identifiable, CaseIterable {
    case bottom
    case opacity
    case scale

    var id: String { .init(describing: self) }
    var value: AnyTransition {
        switch self {
        case .bottom: .move(edge: .bottom)
        case .opacity: .opacity
        case .scale: .scale
        }
    }
}
