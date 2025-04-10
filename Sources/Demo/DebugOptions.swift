import SwiftUI

enum DebugBackground: Identifiable, CaseIterable {
    case clear
    case material
    case brown

    var id: String { .init(describing: self) }
    var value: AnyShapeStyle {
        switch self {
        case .clear: .init(Color.clear)
        case .material: .init(.regularMaterial)
        case .brown: .init(Color.brown)
        }
    }
}
