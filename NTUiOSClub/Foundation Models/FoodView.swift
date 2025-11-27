//
//  FoodView.swift
//  NTUiOSClub
//
//  Created by ethanhuang on 2025/11/27.
//

import FoundationModels
import SwiftUI

// MARK: 把 Foundation Models 放進 SwiftUI
struct FoodView: View {
  @State private var response = "正在準備"

  var body: some View {
    List {
      Text(response)
    }
    .toolbar {
      ToolbarItem(placement: .primaryAction) {
        Button {
          startStreamResponse()
        } label: {
          Image(systemName: "arrowtriangle.forward.fill")
        }
      }
    }
  }

  func startStreamResponse() {
    Task {
      let session = LanguageModelSession(
        model: SystemLanguageModel.default,
        instructions: "這是一個關於美食的對話"
      )

      let stream = session.streamResponse(to: "午餐要吃什麼？我在台大")
      for try await partialResponse in stream {
        withAnimation {
          response = partialResponse.content
        }
      }
    }
  }
}

#Preview {
  FoodView()
}
