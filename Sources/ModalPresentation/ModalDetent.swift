import Foundation

public enum ModalDetent: Hashable {
    case small
    case medium
    case large
    case fullscreen
    case fraction(CGFloat)
    case height(CGFloat)

    func resolve(for height: CGFloat) -> CGFloat {
        switch self {
        case .small: height * 0.25
        case .medium: height * 0.4
        case .large: height * 0.9
        case .fullscreen: height
        case .fraction(let fraction): height * fraction
        case .height(let height): height
        }
    }
}
