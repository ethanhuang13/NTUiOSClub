import SwiftUI

struct MacminiM4TopView: View {
  private var cornerRadius: Double { bodyWidth / 4 }
  private var appleLogoSize: Double { bodyWidth / 3.5 }

  var body: some View {
    RoundedRectangle(cornerRadius: cornerRadius)
      .aspectRatio(1, contentMode: .fit)
      .foregroundStyle(
        LinearGradient(
          colors: [Color(white: 0.9), Color(white: 0.8)],
          startPoint: .topTrailing,
          endPoint: .bottomLeading
        )
      )
      .frame(width: bodyWidth)
      .overlay {
        Image(systemName: "apple.logo")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: appleLogoSize)
          .foregroundStyle(Color.black)
      }
  }
}

#Preview("Top View") {
  MacminiM4TopView()
}
