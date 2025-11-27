//
//  FoodView.swift
//  NTUiOSClub
//
//  Created by ethanhuang on 2025/11/27.
//

import AnyLanguageModel
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
      let model = OpenAILanguageModel(
        baseURL: URL(string: "http://127.0.0.1:1234/v1")!,
        apiKey: "",
        model: "openai/gpt-oss-20b"
      )

      let session = LanguageModelSession(
        model: model,
        instructions: "這是一個關於美食的對話"
      )

      let stream = session.streamResponse(to: "午餐要吃什麼？我在台大")
      for try await partialResponse in stream {
        response = partialResponse.content
      }
    }
  }
}

#Preview {
  FoodView()
}
