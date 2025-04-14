import SwiftUI
import ModalPresentation

enum DemoExample: Identifiable, CaseIterable {
    case weather
    case confirmation
    case image

    var id: String { .init(describing: self) }
}

struct DemoExampleView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var animateGradient = false
    @State private var movingOffset = false

    let example: DemoExample

    var body: some View {
        switch example {
        case .weather:
            ScrollView {
                HStack(alignment: .top) {
                    Image(systemName: "cloud.sun")
                        .font(.system(size: 80))
                        .padding(8)
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity)
                    VStack(spacing: 10) {
                        ForEach(0..<23) { index in
                            HStack {
                                Text(.seconds(index * 3600), format: .time(pattern: .hourMinute))
                                Spacer()
                                Text("\(Int.random(in: 10...36))°C")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(20)
            }
        case .confirmation:
            VStack {
                Text("Are you sure?")
                    .font(.title2)
                Text("This operation is not irreversible")
                    .font(.caption)
                    .padding(.bottom, 15)
                Button {
                    dismiss()
                } label: {
                    Text("Confirm")
                        .fontWeight(.semibold)
                        .padding()
                        .background(
                            Capsule()
                                .fill(.ultraThinMaterial)
                        )
                }
            }
        case .image:
            ZStack {
                ZStack {
                    // Animated gradient shapes
                    ZStack {
                        Circle()
                            .fill(Color.blue.opacity(0.8))
                            .frame(width: 300, height: 300)
                            .offset(x: movingOffset ? 50 : -50, y: movingOffset ? -100 : 100)
                            .blur(radius: 60)

                        // Second blob
                        Circle()
                            .fill(Color.purple.opacity(0.8))
                            .frame(width: 250, height: 250)
                            .offset(x: movingOffset ? -100 : 100, y: movingOffset ? 50 : -50)
                            .blur(radius: 60)
                    }
                }
                .ignoresSafeArea()
                .onAppear {
                    // Begin animations
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        movingOffset.toggle()
                    }
                    withAnimation(.linear(duration: 6).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
                Image(systemName: "apple.logo")
                    .resizable()
                    .aspectRatio(0.85, contentMode: .fit)
                    .frame(maxWidth: 200, maxHeight: .infinity)
            }
        }
    }
}
