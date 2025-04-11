import SwiftUI
import ModalPresentation

struct DemoView: View {
    @State var isPresented = false
    @State var canGoFullscreen = false
    @State var selectedDetent: ModalDetent = .large
    @State var allowDetents: [ModalDetent]?

    @State var debugToolbar = true
    @State var dismissInteractionDisabled = false
    @State var demoBackground: DemoBackground = .material
    @State var demoBackdrop: DemoBackdrop = .shade
    @State var demoCornerRadius: CGFloat = 12
    @State var demoTransition: DemoTransition = .bottom

    var body: some View {
        List {
            Section("Modals") {
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
                Toggle(isOn: $dismissInteractionDisabled) {
                    Text("Dismiss Interaction Disabled")
                }
                HStack {
                    Text("Background")
                    Spacer()
                    Picker(
                        selection: $demoBackground,
                        content: {
                            ForEach(DemoBackground.allCases, id: \.self) { option in
                                Text("\(option)")
                                    .font(.footnote)
                            }
                        },
                        label: EmptyView.init
                    )
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: 260)
                }
                HStack {
                    Text("Backdrop")
                    Spacer()
                    Picker(
                        selection: $demoBackdrop,
                        content: {
                            ForEach(DemoBackdrop.allCases, id: \.self) { option in
                                Text("\(option)")
                                    .font(.footnote)
                            }
                        },
                        label: EmptyView.init
                    )
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: 260)
                }
                HStack {
                    Text("Transition")
                    Spacer()
                    Picker(
                        selection: $demoTransition,
                        content: {
                            ForEach(DemoTransition.allCases, id: \.self) { option in
                                Text("\(option)")
                                    .font(.footnote)
                            }
                        },
                        label: EmptyView.init
                    )
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: 260)
                }
                HStack {
                    Text("Corner Radius")
                    Spacer()
                    Slider(value: $demoCornerRadius, in: 0...80)
                        .frame(maxWidth: 260)
                }
            }
        }
        .safeAreaInset(edge: .top) {
            Text("Modal")
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
        .modalPresentation(interactiveDismissDisabled: dismissInteractionDisabled)
        .modalPresentation(background: demoBackground.value)
        .modalPresentation(backdrop: demoBackdrop.value)
        .modalPresentation(cornerRadius: demoCornerRadius)
        .modalPresentation(transition: demoTransition.value)
    }

    private var demoContent: some View {
        DemoWeatherView()
    }
}

#Preview {
    DemoView()
}
