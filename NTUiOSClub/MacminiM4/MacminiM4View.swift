import SwiftUI

let bodyWidth = 512.0

struct MacminiM4View: View {
  @State private var viewPoint = ViewPoint.top
  @State private var powerState = MacPowerState()

  var body: some View {
    ZStack {
      Color.clear

      MacminiM4TopView()
        .rotation3DEffect(
          .degrees(viewPoint.degrees),
          axis: (x: 1, y: 0, z: 0),
          anchorZ: -100
        )
        .opacity(viewPoint == .top ? 1 : 0)

      MacminiM4SideView(powerState: powerState)
        .rotation3DEffect(
          .degrees(90 - viewPoint.degrees),
          axis: (x: -1, y: 0, z: 0),
          anchorZ: -100
        )
        .opacity(viewPoint == .side ? 1 : 0)

      MacminiM4BottomView(powerState: powerState)
        .rotationEffect(.degrees(180))
        .rotation3DEffect(
          .degrees(180 - viewPoint.degrees),
          axis: (x: -1, y: 0, z: 0),
          anchorZ: -100
        )
        .opacity(viewPoint == .bottom ? 1 : 0)
    }
    .animation(.spring, value: viewPoint)
    .overlay(alignment: .bottom) {
      Picker(
        selection: $viewPoint,
        content: {
          ForEach(ViewPoint.allCases, id: \.self) { viewPoint in
            Text(viewPoint.title)
              .tag(viewPoint)
          }
        },
        label: {}  // 可以留空
      )
      .pickerStyle(.segmented)
      .padding()
    }
  }
}

#Preview {
  MacminiM4View()
}
