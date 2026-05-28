import Foundation

@Observable
class DrinkOrderViewModel {
  var customerName = ""
  var sweetness: Sweetness = .halfSugar
  var iceLevel = 0.5
  var wantsBoba = true
  var size: DrinkSize = .large
  var cupCount = 1
  var pickupTime = Date.now.addingTimeInterval(30 * 60)

  enum DrinkSize: String, CaseIterable, Identifiable {
    case small = "小杯"
    case medium = "中杯"
    case large = "大杯"
    case extraLarge = "特大杯"

    var id: Self { self }
  }

  enum Sweetness: String, CaseIterable, Identifiable {
    case noSugar = "無糖"
    case lessSugar = "微糖"
    case halfSugar = "半糖"
    case moreSugar = "多糖"
    case fullSugar = "全糖"

    var id: Self { self }

    var sliderValue: Double {
      switch self {
      case .noSugar:
        0.0
      case .lessSugar:
        0.25
      case .halfSugar:
        0.5
      case .moreSugar:
        0.75
      case .fullSugar:
        1.0
      }
    }

    var percentageText: String {
      "\(Int(sliderValue * 100))%"
    }

    static func from(sliderValue: Double) -> Self {
      switch sliderValue {
      case 0.0:
        .noSugar
      case 0.25:
        .lessSugar
      case 0.5:
        .halfSugar
      case 0.75:
        .moreSugar
      default:
        .fullSugar
      }
    }
  }

  enum IceLevelOption: String, CaseIterable, Identifiable {
    case noIce = "去冰"
    case lessIce = "微冰"
    case regularIce = "少冰"
    case moreIce = "正常冰"
    case extraIce = "多冰"

    var id: Self { self }

    var sliderValue: Double {
      switch self {
      case .noIce:
        0.0
      case .lessIce:
        0.25
      case .regularIce:
        0.5
      case .moreIce:
        0.75
      case .extraIce:
        1.0
      }
    }

    static func from(sliderValue: Double) -> Self {
      switch sliderValue {
      case 0.0:
        .noIce
      case 0.25:
        .lessIce
      case 0.5:
        .regularIce
      case 0.75:
        .moreIce
      default:
        .extraIce
      }
    }
  }
}
