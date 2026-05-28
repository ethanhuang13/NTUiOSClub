import FoundationModels

@Generable()
struct Drink {
  var sweetness: DrinkOrderViewModel.Sweetness
  var iceLevel: DrinkOrderViewModel.IceLevelOption
  var wantsBoba: Bool
  var size: DrinkOrderViewModel.DrinkSize
  var cupCount: Int
}

extension DrinkOrderViewModel {
  func generate() {
    let session = LanguageModelSession(instructions: "用來生成點飲料表單")

    Task {
      do {
        self.isGenerating = true
        let response = try await session.respond(generating: Drink.self) {
          self.prompt
          // 我要三杯微糖半冰有珍珠，超大杯
        }

        let drink = response.content
        print(drink)

        self.sweetness = drink.sweetness
        self.iceOption = drink.iceLevel
        self.wantsBoba = drink.wantsBoba
        self.size = drink.size
        self.cupCount = drink.cupCount

        self.isGenerating = false

        print(session.transcript)
      } catch {
        print(error)

        self.isGenerating = false
      }
    }
  }
}
