import SwiftUI

struct MacminiM4SideView: View {
  private let bodyWidth = 512.0
  private let bodyAspectRatio = 3.0
  private var bodyHeight: Double {
    bodyWidth / bodyAspectRatio
  }

  var body: some View {
    VStack(spacing: 0) {
      topPart
      bottomPart
    }
    .padding()
  }

  @ViewBuilder
  private var topPart: some View {
    Rectangle()
      .foregroundStyle(
        LinearGradient(
          stops: [
            .init(color: Color.black.opacity(0.3), location: 0.0),
            .init(color: Color.black.opacity(0.1), location: 0.1),
            .init(color: Color.black.opacity(0.1), location: 0.9),
            .init(color: Color.black.opacity(0.3), location: 1.0),
          ],
          startPoint: .leading,
          endPoint: .trailing
        )
      )
      .aspectRatio(bodyAspectRatio, contentMode: .fit)
      .frame(width: bodyWidth)
      .overlay {
        HStack {
          Spacer()

          HStack(spacing: bodyWidth / 16) {
            usbCPort
            usbCPort
          }

          Spacer()
          Spacer()

          HStack(spacing: bodyWidth / 16) {
            powerIndicator
            audioPort
          }

          Spacer()
        }
        .offset(y: bodyHeight / 8)
      }
  }

  @ViewBuilder
  private var usbCPort: some View {
    Capsule()
      .aspectRatio(1 / 3.5, contentMode: .fit)
      .frame(height: bodyHeight / 5)
  }

  @ViewBuilder
  private var powerIndicator: some View {
    Circle()
      .foregroundStyle(Color.white)
      .frame(height: bodyHeight / 20)
  }

  @ViewBuilder
  private var audioPort: some View {
    Circle()
      .foregroundStyle(Color.black)
      .frame(height: bodyHeight / 10)
  }

  @ViewBuilder
  private var bottomPart: some View {
    Rectangle()
      .rotation3DEffect(.degrees(-60), axis: (x: 1, y: 0, z: 0))
      .foregroundStyle(
        LinearGradient(
          colors:
            Array(
              repeating: [Color.black, Color.black.opacity(0.8)],
              count: 32
            ).flatMap { $0 },
          startPoint: .leading,
          endPoint: .trailing
        )
      )
      .frame(width: bodyWidth * 0.8, height: bodyHeight * 0.2)
      .offset(y: bodyHeight / -22)
  }
}

#Preview("Side View") {
  MacminiM4SideView()
}
