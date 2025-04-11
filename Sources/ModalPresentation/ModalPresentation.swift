import SwiftUI

struct ModalPresentation<PresentedContent: View>: ViewModifier {
    @Environment(\.modalTransition) private var modalTransition
    @Environment(\.modalBackdrop) private var modalBackdrop

    @State private var isFullScreenCoverPresented = false
    @State private var isFullScreenCoverVisible = false

    @Binding private var isPresented: Bool
    private var onDismiss: (() -> Void)?
    private var presentedContent: () -> PresentedContent

    init(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> PresentedContent
    ) {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.presentedContent = content
    }

    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented, initial: true) {
                if isPresented {
                    Transaction.with(animation: nil) {
                        isFullScreenCoverPresented = true
                    } completion: {
                        withAnimation(.linear(duration: 0.25)) {
                            isFullScreenCoverVisible = true
                        }
                    }
                } else {
                    withAnimation(.linear(duration: 0.25)) {
                        isFullScreenCoverVisible = false
                    } completion: {
                        Transaction.with(animation: nil) {
                            isFullScreenCoverPresented = false
                        }
                    }
                }
            }
            .onChange(of: isFullScreenCoverPresented, initial: false) {
                guard !isFullScreenCoverPresented, isFullScreenCoverVisible else { return }
                isFullScreenCoverPresented = true
                isPresented = false
            }
            .fullScreenCover(
                isPresented: $isFullScreenCoverPresented,
                onDismiss: onDismiss
            ) {
                Color
                    .clear
                    .background {
                        if isFullScreenCoverVisible {
                            // Backdrop
                            Color.clear
                                .background(modalBackdrop)
                                .ignoresSafeArea()
                                .transition(.opacity)
                        }
                    }
                    .overlay(alignment: .center) {
                        if isFullScreenCoverVisible {
                            // Content
                            VStack {
                                presentedContent()
                            }
                            .transition(modalTransition)
                        }
                    }
                    .presentationBackground(.clear)
            }
    }
}

extension View {
    func presentation<Content: View>(_ isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(
            ModalPresentation(isPresented: isPresented, onDismiss: onDismiss, content: content)
        )
    }
}

#Preview {
    Text("")
        .presentation(.constant(true)) {
            Text("content")
                .padding(20)
                .background(.thinMaterial)
        }
}
