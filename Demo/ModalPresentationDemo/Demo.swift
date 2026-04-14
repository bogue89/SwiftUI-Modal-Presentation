import ModalPresentation

enum Demo: Identifiable, CaseIterable {
    case `default`
    case single
    case freeResize
    case detents
    case fractions
    case fixed

    var id: String {
        switch self {
        case .`default`: "Default (.large, .fullscreen)"
        case .single: "Single value (.medium)"
        case .freeResize: "Free resize (no detents)"
        case .detents: "Detents (.small, .medium, .large, .fullscreen)"
        case .fractions: "Fractions (0.3, 0.5, 0.99)"
        case .fixed: "fixed (150px, 300px, 600px)"
        }
    }

    var detens: [ModalDetent]? {
        switch self {
        case .`default`: [.large, .fullscreen]
        case .single: nil
        case .freeResize: []
        case .detents: [.small, .medium, .large, .fullscreen]
        case .fractions: [.fraction(0.3), .fraction(0.5), .fraction(0.99)]
        case .fixed: [.height(150), .height(300), .height(600)]
        }
    }
}
