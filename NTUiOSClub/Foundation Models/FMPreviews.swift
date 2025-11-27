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
