import SwiftUI

struct ModalPresentation<PresentedContent: View>: ViewModifier {
    @Environment(\.modalTransition) private var modalTransition

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
                    withoutAnimation {
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
                        withoutAnimation {
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
                            Color
                                .black
                                .opacity(0.1)
                                .ignoresSafeArea()
                                .transition(.opacity)
                                .onTapGesture {
                                    isPresented = false
                                }

                        }
                    }
                    .overlay(alignment: .center) {
                        if isFullScreenCoverVisible {
                            // Content
                            VStack {
                                presentedContent()
                            }
                            .transition(modalTransition)
//                            .padding(20)
//                            .background {
//                                RoundedRectangle(cornerRadius: 10, style: .continuous)
//                                    .fill(.thinMaterial)
//                                    .shadow(radius: 30)
//                                    .ignoresSafeArea()
//                            }
                            .background {
                                Color.clear
                                    .contentShape(Rectangle())
                                    .ignoresSafeArea()
                            }
                        }
                    }
                    .presentationBackground(.clear)
            }
    }
}

extension EnvironmentValues {
    private struct ModalTransitionKey: EnvironmentKey {
        static var defaultValue: AnyTransition = .move(edge: .bottom)
    }
    var modalTransition: AnyTransition {
        get { self[ModalTransitionKey.self] }
        set { self[ModalTransitionKey.self] = newValue }
    }
}

extension View {
    func presentation<Content: View>(_ isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View {
        self.modifier(
            ModalPresentation(isPresented: isPresented, onDismiss: onDismiss, content: content)
        )
    }
}
