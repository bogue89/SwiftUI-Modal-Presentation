import SwiftUI

struct Modal<PresentedContent: View>: ViewModifier {
    @State private var presentedModalHeight: CGFloat = .zero

    @Binding private var isPresented: Bool
    private var onDismiss: (() -> Void)?
    private var presentedContent: () -> PresentedContent
    @State var modalDetent: ModalDetent = .large
    private var modalDetents: [ModalDetent]?

    init(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        content: @escaping () -> PresentedContent,
        modalDetent: Binding<ModalDetent>,
        detents: [ModalDetent]? = nil
    ) {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.presentedContent = content
//        self._modalDetent = modalDetent
        self.modalDetents = detents
    }

    func body(content: Content) -> some View {
        content
            .presentation($isPresented, onDismiss: onDismiss) {
                VStack {
                    presentedContent()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    UnevenRoundedRectangle(
                        topLeadingRadius: 30,
                        topTrailingRadius: 30
                    )
                        .fill(.thinMaterial)
                        .ignoresSafeArea()
                        .onGeometryChange {
                            presentedModalHeight = $0.size.height
                        }
                }
                // TODO: detents logic for .modal modifier
                .resizable($modalDetent, detents: [])
                .background {
                    Color.clear
                        .contentShape(Rectangle())
                        .ignoresSafeArea()
                        .onTapGesture {
                            isPresented = false
                        }
                }
                .onChange(of: modalDetent) { _, value in
                    if case .height(let height) = value,
                       presentedModalHeight > height {
                        isPresented = false
                    }
                }
            }
    }
}

extension View {
    func modal<Content: View>(
        _ isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        modalDetent: Binding<ModalDetent> = .constant(.large),
        detents: [ModalDetent]? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.modifier(
            Modal(
                isPresented: isPresented,
                onDismiss: onDismiss,
                content: content,
                modalDetent: modalDetent,
                detents: detents
            )
        )
    }
}

