import SwiftUI

struct PreviewView: View {
    @State var isPresented = true
    @State var modalDetent = ModalDetent.small

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button {
                isPresented = true
            } label: {
                Text("Sheet")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow.opacity(0.2))
        .modal($isPresented) {
            groupBox
        }
    }
    @ViewBuilder
    var groupBox: some View {
        Text("Info")
        Text("Info")
        Text("Info")
        Button {
            isPresented = false
        } label: {
            Text("dismiss")
        }
    }
    var scrollView: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("Resizable Sheet")
                    .font(.title)
                Button {
                    modalDetent = .small
                } label: {
                    Text("small")
                }
                Button {
                    modalDetent = .medium
                } label: {
                    Text("medium")
                }
                Button {
                    modalDetent = .large
                } label: {
                    Text("large")
                }
                Button {
                    modalDetent = .fullscreen
                } label: {
                    Text("fullscreen")
                }
                Button {
                    modalDetent = .fraction(0.5)
                } label: {
                    Text("fraction 0.5")
                }
                Button {
                    modalDetent = .height(100)
                } label: {
                    Text("100px")
                }
                ForEach(0..<10) { index in
                    Text("Item \(index)")
                }
            }
        }
        .safeAreaInset(edge: .top) {
            HStack {
                Text("\(modalDetent)")
                    .font(.footnote)
                Spacer()
                Button {
                    isPresented = false
                } label: {
                    Text("Dismiss")
                }
            }
            .padding(.horizontal, 15)
        }
//        .modifier(ModalResize($modalDetent, detents: []))
//        .modifier(ModalResize($modalDetent, detents: []))
//        .modifier(ModalResize($modalDetent, detents: [.small, .large, .height(280), .fullscreen]))
//        .modifier(ModalResize.AutoConnect(detents: [.small, .height(480), .large]))
    }
}
#Preview {
    PreviewView()
}
