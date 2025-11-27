import FoundationModels
import Playgrounds
import SwiftUI

// MARK: One-shot
#Playground("美食") {
  let session = LanguageModelSession(instructions: "這是一個關於美食的對話")
  let response = try await session.respond(to: "午餐要吃什麼？我在台大")
}

// MARK: Streaming Responses
#Playground("Streaming Response") {
  let session = LanguageModelSession(instructions: "這是一個關於美食的對話")
  let stream = session.streamResponse(to: "午餐要吃什麼？我在台大")
  var responses: [String] = []
  for try await partialResponse in stream {
    responses.append(partialResponse.content)
  }
}

// MARK: 把 Foundation Models 放進 SwiftUI
struct FoodView: View {
  @State private var response = "正在準備"

  var body: some View {
    List {
      Text(response)
    }
    .task {
      Task {
        let session = LanguageModelSession(instructions: "這是一個關於美食的對話")

        let stream = session.streamResponse(to: "午餐要吃什麼？我在台大")
        for try await partialResponse in stream {
          withAnimation {
            response = partialResponse.content
          }
        }
      }
    }
  }
}

#Preview {
  FoodView()
}
