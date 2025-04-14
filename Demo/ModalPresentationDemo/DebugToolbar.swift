import SwiftUI
import ModalPresentation

struct DebugToolbar: ViewModifier {

    @Environment(\.dismiss) var dismiss
    let enable: Bool
    @Binding var selectedDetent: ModalDetent
    let allowDetents: [ModalDetent]?

    func body(content: Content) -> some View {
        VStack {
            content
        }
        .frame(maxHeight: .infinity)
        .safeAreaInset(edge: .top) {
            if enable {
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
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .background(.thinMaterial)
            } else {
                EmptyView()
            }
        }
    }
}

extension View {
    func debugToolbar(enable: Bool, selectedDetent: Binding<ModalDetent>, allowDetents: [ModalDetent]?) -> some View {
        modifier(
            DebugToolbar(enable: enable, selectedDetent: selectedDetent, allowDetents: allowDetents)
        )
    }
}

