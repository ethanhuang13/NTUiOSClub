import SwiftUI

struct MacminiM4SideView: View {
  @Bindable var powerState: MacPowerState

  private let bodyAspectRatio = 3.0
  private var bodyHeight: Double { bodyWidth / bodyAspectRatio }
  private var portSpacing: Double { bodyWidth / 16 }
  private var overlayOffsetY: Double { bodyHeight / 8 }
  private var usbCPortHeight: Double { bodyHeight / 5 }
  private var powerIndicatorSize: Double { bodyHeight / 20 }
  private var audioPortSize: Double { bodyHeight / 10 }
  private var ventWidth: Double { bodyWidth * 0.8 }
  private var ventHeight: Double { bodyHeight * 0.2 }
  private var ventOffsetY: Double { bodyHeight / -22 }

  var body: some View {
    VStack(spacing: 0) {
      chassis
      vent
    }
  }

  @ViewBuilder
  private var chassis: some View {
    Rectangle()
      .foregroundStyle(
        LinearGradient(
          stops: [
            .init(color: Color(white: 0.7), location: 0.0),
            .init(color: Color(white: 0.9), location: 0.1),
            .init(color: Color(white: 0.9), location: 0.9),
            .init(color: Color(white: 0.7), location: 1.0),
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
          HStack(spacing: portSpacing) {
            usbCPort
            usbCPort
          }
          Spacer()
          Spacer()
          HStack(spacing: portSpacing) {
            powerIndicator
            audioPort
          }
          Spacer()
        }
        .offset(y: overlayOffsetY)
      }
  }

  @ViewBuilder
  private var usbCPort: some View {
    Capsule()
      .aspectRatio(1 / 3.5, contentMode: .fit)
      .frame(height: usbCPortHeight)
  }

  @ViewBuilder
  private var powerIndicator: some View {
    Circle()
      .foregroundStyle(Color(white: powerState.isOn ? 1 : 0))
      .frame(height: powerIndicatorSize)
  }

  @ViewBuilder
  private var audioPort: some View {
    Circle()
      .foregroundStyle(Color.black)
      .frame(height: audioPortSize)
  }

  @ViewBuilder
  private var vent: some View {
    Rectangle()
      .frame(width: ventWidth, height: ventHeight)
      .rotation3DEffect(.degrees(-60), axis: (x: 1, y: 0, z: 0))
      .offset(y: ventOffsetY)
      .foregroundStyle(
        LinearGradient(
          colors:
            Array(
              repeating: [Color.black, Color.black.opacity(0.8)],
              count: 32
            )
            .flatMap { $0 },
          startPoint: .leading,
          endPoint: .trailing
        )
      )
  }
}

#Preview("Side View") {
  MacminiM4SideView(powerState: .init())
}
