import SwiftUI

struct MacminiM4TopView: View {
  private let bodyWidth = 512.0

  var body: some View {
    RoundedRectangle(cornerRadius: 128)
      .aspectRatio(1, contentMode: .fit)
      .foregroundStyle(
        LinearGradient(
          colors: [
            Color.black.opacity(0.1),
            Color.black.opacity(0.2),
          ],
          startPoint: .topTrailing,
          endPoint: .bottomLeading
        )
      )
      .frame(width: bodyWidth)
      .overlay {
        Image(systemName: "applelogo")
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
