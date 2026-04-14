import SwiftUI

struct ModalResize: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modalCornerRadius) private var modalCornerRadius
    @Environment(\.modalInteractiveDismiss) private var modalInteractiveDismiss
    /// Drag state
    @GestureState private var isDragging = false
    @State private var showDragIndicator = true
    @State private var dragVerticalInertia: CGFloat = .zero
    /// Height calculation
    @State private var currentHeight: CGFloat = 0
    @State private var maxHeight: CGFloat = 0
    @State private var minHeight: CGFloat = 0

    @Binding var modalDetent: ModalDetent {
        didSet {
            // If values are the same the `.onChange` will not fire.
            // we need to make sure we height position is correct after dragging
            guard oldValue == modalDetent else { return }
            resolveHeight()
        }
    }
    private var modalDetents: [ModalDetent]?

    init(_ modalDetent: Binding<ModalDetent>, detents: [ModalDetent]? = []) {
        self._modalDetent = modalDetent
        self.modalDetents = detents
    }

    func body(content: Content) -> some View {
        Color
            .clear
            .onGeometryChange {
                maxHeight = $0.size.height
            }
            .overlay(alignment: .bottom) {
                VStack(spacing: 0) {
                    content
                        .safeAreaInset(edge: .top, spacing: 0) {
                            // Drag Handle
                            if showDragIndicator{
                                DragIndicator()
                                    .padding(10)
                                    .transition(.opacity)
                                    .frame(maxWidth: .infinity, alignment: .top)
                                    .contentShape(Rectangle())
                                    .layoutPriority(1)
                                    .onGeometryChange {
                                        minHeight = $0.size.height * 2
                                    }
                            }
                        }
                        .clipShape(clipShapeStyle)
                        .ignoresSafeArea(edges: .bottom)
                }
                .frame(maxWidth: .infinity)
                .frame(height: max(currentHeight, minHeight), alignment: .top)
                .contentShape(Rectangle())
                .gesture(dragGesture)
                .onChange(of: isDragging) { _, value in
                    guard !value else { return }
                    didDragEnd(with: dragVerticalInertia)
                }
                .onChange(of: maxHeight) { oldValue, newValue in
                    guard !isDragging else { return }
                    resolveHeight(animated: oldValue != 0)
                }
                .onChange(of: modalDetent, initial: false) { _, value in
                    resolveHeight()
                }
            }
    }

    private func resolveHeight(animated: Bool = true) {
        guard maxHeight > 0 else { return }
        let height = modalDetent.resolve(for: maxHeight)
        Transaction.with(animation: animated ? .easeOut : nil) {
            showDragIndicator = true
            switch height {
            case ..<30:
                currentHeight = 30
            case maxHeight...:
                currentHeight = maxHeight
                showDragIndicator = false
            default:
                currentHeight = height
            }
        }
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .updating($isDragging) { _, state, _ in
                state = true
            }
            .onChanged { value in
                didDragChange(with: value.translation.height)
                dragVerticalInertia = 0
//                print(value.translation.height, value.predictedEndTranslation.height, value.velocity.height)
            }
            .onEnded { value in
                // TODO: Normalize velocity to predicted iternia landing
                dragVerticalInertia = 0
            }
    }

    private func didDragChange(with verticalTranslation: CGFloat) {
        currentHeight -= verticalTranslation
        withAnimation {
            showDragIndicator = true
        }
    }

    private func didDragEnd(with predictedVerticalTranslation: CGFloat) {
        let height = currentHeight + predictedVerticalTranslation
        if modalInteractiveDismiss, height.isLessThanOrEqualTo(0) {
            dismiss()
        }
        let detent = closesDetent(
            to: height,
            in: maxHeight,
            using: modalDetents ?? [modalDetent]
        )
        switch detent {
        case .height(let value) where value >= maxHeight:
            self.modalDetent = .fullscreen
        case .height(let value) where value < minHeight:
            self.modalDetent = .height(minHeight)
        default:
            self.modalDetent = detent
        }
    }

    private func closesDetent(to target: CGFloat, in maxHeight: CGFloat, using detents: [ModalDetent]) -> ModalDetent {
        detents.min {
            abs($0.resolve(for: maxHeight) - target) < abs($1.resolve(for: maxHeight) - target)
        } ?? .height(target)
    }

    private var clipShapeStyle: AnyShape {
        if !isFullscreenDetent {
            .init(UnevenRoundedRectangle(
                topLeadingRadius: modalCornerRadius,
                topTrailingRadius: modalCornerRadius
            ))
        } else {
            .init(Rectangle().scale(2))
        }
    }

    private var isFullscreenDetent: Bool {
        if case .fullscreen = modalDetent {
            true
        } else {
            false
        }
    }
}

extension ModalResize {
    struct AutoConnect: ViewModifier {
        @State private var modalDetent: ModalDetent
        private let detents: [ModalDetent]
        init(detents: [ModalDetent] = []) {
            self._modalDetent = .init(initialValue: detents.first ?? .large)
            self.detents = detents
        }
        func body(content: Content) -> some View {
            content.modifier(ModalResize($modalDetent, detents: detents))
        }
    }
}

extension View {
    func resizable(_ modalDetent: Binding<ModalDetent>, detents: [ModalDetent]? = []) -> ModifiedContent<Self, ModalResize>{
        modifier(ModalResize(modalDetent, detents: detents))
    }

    func resizable(detents: [ModalDetent] = []) -> ModifiedContent<Self, ModalResize.AutoConnect>{
        modifier(ModalResize.AutoConnect(detents: detents))
    }
}
