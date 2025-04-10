import SwiftUI
import ModalPresentation

struct DemoView: View {
    @State var isPresented = false
    @State var canGoFullscreen = false
    @State var selectedDetent: ModalDetent = .large
    @State var allowDetents: [ModalDetent]?

    @State var debugToolbar = true
    @State var debugBackground: DebugBackground = .material

    var body: some View {
        List {
            Section("Demo") {
                ForEach(Demo.allCases) { demo in
                    Button {
                        isPresented = true
                        selectedDetent = demo.detens?.last(where: { $0 != .fullscreen }) ?? .medium
                        allowDetents = demo.detens
                    } label: {
                        Text(demo.id)
                    }
                }
            }
            Section("Options") {
                Toggle(isOn: $debugToolbar) {
                    Text("Debug toolbar")
                }
                HStack {
                    Text("Background")
                    Spacer()
                    Picker(
                        selection: $debugBackground,
                        content: {
                            ForEach(DebugBackground.allCases, id: \.self) { background in
                                Text("\(background)")
                                    .font(.footnote)
                            }
                        },
                        label: EmptyView.init
                    )
                    .pickerStyle(SegmentedPickerStyle())
                    .controlSize(.small)
                }
            }
        }
        .modal(
            $isPresented,
            modalDetent: $selectedDetent,
            detents: allowDetents
        ) {
            if debugToolbar {
                demoContent.debugToolbar(selectedDetent: $selectedDetent, allowDetents: allowDetents)
            } else {
                demoContent
            }
        }
        .modalPresentation(background: debugBackground.value)
    }

    private var demoContent: some View {
        DemoWeatherView()
    }
}

#Preview {
    DemoView()
}
