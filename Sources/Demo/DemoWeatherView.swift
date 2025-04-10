import SwiftUI
import ModalPresentation

enum DemoOption {
    case weather
    case confirmation
    case image
}
struct DemoWeatherView: View {
    var body: some View {
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
    }
}
