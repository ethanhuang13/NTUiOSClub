import SwiftUI

struct MacminiM4TopView: View {
  private let bodyWidth = 512.0

  var body: some View {
    RoundedRectangle(cornerRadius: bodyWidth / 4)
      .aspectRatio(1, contentMode: .fit)
      .foregroundStyle(
        LinearGradient(
          colors: [
            Color(white: 0.9),
            Color(white: 0.8),
          ],
          startPoint: .topTrailing,
          endPoint: .bottomLeading
        )
      )
      .frame(width: bodyWidth)
      .overlay {
        Image(systemName: "apple.logo")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: bodyWidth / 3.5)
      }
      .padding()
  }
}

#Preview("Top View") {
  MacminiM4TopView()
}
