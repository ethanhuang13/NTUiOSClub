import SwiftUI

struct MacminiM4BottomView: View {
  private let bodyWidth = 512.0

  var body: some View {
    RoundedRectangle(cornerRadius: bodyWidth / 4)
      .aspectRatio(1, contentMode: .fit)
      .frame(width: bodyWidth)
      .foregroundStyle(Color(white: 0.2))
      .overlay {
        ZStack {
          ForEach(0..<128) { tick in
            VStack {
              Capsule()
                .frame(
                  width: bodyWidth * 0.025 / 2,
                  height: bodyWidth * 0.05
                )
                .foregroundStyle(Color(white: 0.05))
              Spacer()
            }
            .rotationEffect(.degrees(360.0 / 128 * Double(tick)))
          }
        }
        .frame(height: bodyWidth * 0.8)
      }
      .overlay {
        Circle()
          .foregroundStyle(Color(white: 0.2))
          .frame(width: bodyWidth * 0.7)
      }
      .overlay {
        Text("Mac mini")
          .font(.system(size: bodyWidth / 12))
          .fontWeight(.medium)
          .foregroundStyle(Color(white: 0.1))
      }
      .overlay(alignment: .topTrailing) {
        // Power Button
        Circle()
          .foregroundStyle(Color(white: 0.1))
          .frame(width: bodyWidth / 12)
          .overlay {
            Image(systemName: "power")
              .foregroundStyle(Color.white)
          }
          .padding(bodyWidth / 8)
      }
  }
}

#Preview {
  MacminiM4BottomView()
}
