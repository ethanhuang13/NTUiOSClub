import SwiftUI

struct MacminiM4BottomView: View {
  @Bindable var powerState: MacPowerState

  private let bodyWidth = 512.0

  var body: some View {
    RoundedRectangle(cornerRadius: bodyWidth / 4)
      .aspectRatio(1, contentMode: .fit)
      .frame(width: bodyWidth)
      .foregroundStyle(Color(white: 0.7))
      .overlay {
        plasticCover
      }
      .overlay {
        vents
          .frame(height: bodyWidth * 0.8)
      }
      .overlay {
        macMiniLogo
      }
      .overlay(alignment: .topTrailing) {
        powerButton
      }
  }

  @ViewBuilder
  private var plasticCover: some View {
    ContainerRelativeShape()
      .aspectRatio(1, contentMode: .fit)
      .foregroundStyle(Color(white: 0.2))
      .padding(bodyWidth / 50)
      .containerShape(RoundedRectangle(cornerRadius: bodyWidth / 4))
  }

  @ViewBuilder
  private var vents: some View {
    ZStack {
      ForEach(0..<108) { tick in
        VStack {
          Capsule()
            .frame(
              width: bodyWidth * 0.025 / 2,
              height: bodyWidth * 0.05
            )
            .foregroundStyle(Color(white: 0.05))
          Spacer()
        }
        .rotationEffect(.degrees(360.0 / 108 * Double(tick)))
      }
    }
  }

  @ViewBuilder
  private var macMiniLogo: some View {
    Text("Mac mini")
      .font(.system(size: bodyWidth / 12))
      .fontWeight(.medium)
      .foregroundStyle(Color(white: 0.1))
  }

  @ViewBuilder
  private var powerButton: some View {
    Button(
      action: {
        powerState.isOn.toggle()
      },
      label: {
        Circle()
          .foregroundStyle(Color(white: 0.1))
          .frame(width: bodyWidth / 12)
          .overlay {
            Image(systemName: "power")
              .foregroundStyle(Color.white)
          }
          .padding(bodyWidth / 9)
      }
    )
  }
}

#Preview {
  MacminiM4BottomView(powerState: MacPowerState())
}
