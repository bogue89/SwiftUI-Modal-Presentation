import SwiftUI

struct Modal<PresentedContent: View>: ViewModifier {
    @Environment(\.modalPresentationBackground) private var modalBackground
    @Environment(\.modalPresentationCornerRadius) private var modalCornerRadius

    @State private var presentedModalHeight: CGFloat = .zero

    @Binding private var isPresented: Bool
    @Binding private var modalDetent: ModalDetent
    private var modalDetents: [ModalDetent]?
    private var onDismiss: (() -> Void)?
    private var presentedContent: () -> PresentedContent

    init(
        isPresented: Binding<Bool>,
        modalDetent: Binding<ModalDetent>,
        detents: [ModalDetent]? = nil,
        onDismiss: (() -> Void)? = nil,
        content: @escaping () -> PresentedContent
    ) {
        self._isPresented = isPresented
        self._modalDetent = modalDetent
        self.modalDetents = detents
        self.onDismiss = onDismiss
        self.presentedContent = content
    }

    func body(content: Content) -> some View {
        content
            .presentation($isPresented, onDismiss: onDismiss) {
                VStack {
                    presentedContent()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(modalBackground)
//                .background {
//                    UnevenRoundedRectangle(
//                        topLeadingRadius: 0,
//                        topTrailingRadius: 0
//                    )
//                        .fill(.gray)
//                        .ignoresSafeArea()
//                        .onGeometryChange {
//                            presentedModalHeight = $0.size.height
//                        }
//                }
                .resizable($modalDetent, detents: modalDetents)
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
//                        isPresented = false
                    }
                }
            }
    }
}

extension View {
    public func modal<Content: View>(
        _ isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        modalDetent: Binding<ModalDetent> = .constant(.large),
        detents: [ModalDetent]? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.modifier(
            Modal(
                isPresented: isPresented,
                modalDetent: modalDetent,
                detents: detents,
                onDismiss: onDismiss,
                content: content
            )
        )
    }
}

