import SwiftUI
import ModalPresentation

struct DebugToolbar: ViewModifier {

    @Environment(\.dismiss) var dismiss
    @Binding var selectedDetent: ModalDetent
    let allowDetents: [ModalDetent]?

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .top) {
                VStack(spacing: 10) {
                    HStack {
                        Text("\(selectedDetent)")
                            .font(.footnote)
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            Text("Dismiss")
                        }
                    }
                    Text("Resizable Sheet")
                        .font(.title)
                    if let allowDetents, !allowDetents.isEmpty {
                        Picker(
                            selection: $selectedDetent,
                            content: {
                                ForEach(allowDetents, id: \.self) { detent in
                                    Text("\(detent)")
                                }
                            },
                            label: EmptyView.init
                        )
                        .pickerStyle(.segmented)
                    }
                }
                .padding(.horizontal, 15)
                .background(.thinMaterial)
            }
    }
}

extension View {
    func debugToolbar(selectedDetent: Binding<ModalDetent>, allowDetents: [ModalDetent]?) -> some View {
        modifier(
            DebugToolbar(selectedDetent: selectedDetent, allowDetents: allowDetents)
        )
    }
}

