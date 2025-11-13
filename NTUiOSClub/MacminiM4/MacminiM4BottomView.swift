import SwiftUI

struct MacminiM4BottomView: View {
  @Bindable var powerState: MacPowerState

  private var cornerRadius: Double { bodyWidth / 4 }
  private var plasticCoverPadding: Double { bodyWidth / 50 }
  private var ventTickWidth: Double { bodyWidth * 0.025 / 2 }
  private var ventTickHeight: Double { bodyWidth * 0.05 }
  private var logoFontSize: Double { bodyWidth / 12 }
  private var powerButtonSize: Double { bodyWidth / 12 }
  private var powerButtonIconSize: Double { bodyWidth / 24 }
  private var powerButtonPadding: Double { bodyWidth / 9 }

  var body: some View {
    chassis
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

  private var chassis: RoundedRectangle {
    RoundedRectangle(cornerRadius: cornerRadius)
  }

  @ViewBuilder
  private var plasticCover: some View {
    ContainerRelativeShape()
      .aspectRatio(1, contentMode: .fit)
      .foregroundStyle(Color(white: 0.2))
      .padding(plasticCoverPadding)
      .containerShape(chassis)
  }

  @ViewBuilder
  private var vents: some View {
    ZStack {
      ForEach(0..<108) { tick in
        VStack {
          Capsule()
            .frame(
              width: ventTickWidth,
              height: ventTickHeight
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
      .font(.system(size: logoFontSize))
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
          .frame(width: powerButtonSize)
          .overlay {
            Image(systemName: "power")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: powerButtonIconSize)
              .foregroundStyle(Color.white)
          }
          .padding(powerButtonPadding)
      }
    )
    .buttonStyle(.plain)
  }
}

#Preview {
  MacminiM4BottomView(powerState: MacPowerState())
}
