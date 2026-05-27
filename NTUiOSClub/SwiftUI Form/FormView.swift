import SwiftUI

@Observable
class FormViewModel {
  enum DrinkSize: String, CaseIterable, Identifiable {
    case small = "小杯"
    case medium = "中杯"
    case large = "大杯"

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

  var customerName = ""
  var wantsBoba = true
  var cupCount = 1
  var iceLevel = 0.6
  var size: DrinkSize = .large
  var sweetness: Sweetness = .halfSugar
  var pickupTime = Date.now.addingTimeInterval(30 * 60)

  var icePercentageText: String {
    "\(Int(iceLevel * 100))%"
  }

  var sweetnessSliderValue: Double {
    get { sweetness.sliderValue }
    set { sweetness = Sweetness.from(sliderValue: newValue) }
  }

  var iceOption: IceLevelOption {
    get { IceLevelOption.from(sliderValue: iceLevel) }
    set { iceLevel = newValue.sliderValue }
  }

  var orderSummary: String {
    let name = customerName.isEmpty ? "未填姓名" : customerName
    let topping = wantsBoba ? "加珍珠" : "不加珍珠"
    return
      "\(name)・\(size.rawValue)・\(sweetness.rawValue)・冰塊 \(icePercentageText)・\(topping)・\(cupCount) 杯"
  }
}

struct FormView: View {
  @State private var viewModel = FormViewModel()

  var body: some View {
    NavigationStack {
      Form {
        Section("點餐人") {
          TextField("輸入姓名", text: $viewModel.customerName)
            .textInputAutocapitalization(.never)
        }

        Section("飲料設定") {
          Picker("甜度", selection: $viewModel.sweetness) {
            ForEach(FormViewModel.Sweetness.allCases) { sweetness in
              Text(sweetness.rawValue).tag(sweetness)
            }
          }
          .pickerStyle(.menu)

          VStack(alignment: .leading, spacing: 8) {
            HStack {
              Text("甜度比例")
              Spacer()
              Text(viewModel.sweetness.percentageText)
                .foregroundStyle(.secondary)
            }

            Slider(
              value: Binding(
                get: { viewModel.sweetnessSliderValue },
                set: { viewModel.sweetnessSliderValue = $0 }
              ),
              in: 0...1.0,
              step: 0.25
            )
          }

          Toggle("加珍珠", isOn: $viewModel.wantsBoba)

          Picker(
            "冰塊",
            selection: Binding(
              get: { viewModel.iceOption },
              set: { viewModel.iceOption = $0 }
            )
          ) {
            ForEach(FormViewModel.IceLevelOption.allCases) { iceOption in
              Text(iceOption.rawValue).tag(iceOption)
            }
          }
          .pickerStyle(.navigationLink)

          VStack(alignment: .leading, spacing: 8) {
            HStack {
              Text("冰塊比例")
              Spacer()
              Text(viewModel.icePercentageText)
                .foregroundStyle(.secondary)
            }

            Slider(value: $viewModel.iceLevel, in: 0...1, step: 0.25)
          }

          Picker("杯型", selection: $viewModel.size) {
            ForEach(FormViewModel.DrinkSize.allCases) { size in
              Text(size.rawValue).tag(size)
            }
          }
          .pickerStyle(.segmented)

          Stepper(
            "杯數：\(viewModel.cupCount)",
            value: $viewModel.cupCount,
            in: 1...10
          )
        }

        Section("取餐時間") {
          DatePicker(
            "預計取餐",
            selection: $viewModel.pickupTime,
            in: Date.now...,
            displayedComponents: [.date, .hourAndMinute]
          )
        }

        Section("訂單摘要") {
          LabeledContent("飲料") {
            Text("珍珠奶茶")
          }

          Text(viewModel.orderSummary)
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
      }
      .navigationTitle("點飲料表單")
      .navigationBarTitleDisplayMode(.inline)
    }
  }

  init(viewModel: FormViewModel = FormViewModel()) {
    _viewModel = State(initialValue: viewModel)
  }
}

#Preview("預設") {
  FormView()
}

#Preview("大杯無糖少冰奶茶 x 2") {
  let viewModel = FormViewModel()
  viewModel.customerName = "13"
  viewModel.wantsBoba = false
  viewModel.cupCount = 2
  viewModel.iceLevel = 0.5
  viewModel.size = .large
  viewModel.sweetness = .noSugar
  return FormView(viewModel: viewModel)
}

#Preview("30 大杯全糖全冰訂單") {
  let viewModel = FormViewModel()
  viewModel.customerName = "iOS Club"
  viewModel.wantsBoba = true
  viewModel.cupCount = 30
  viewModel.iceLevel = 1.0
  viewModel.size = .large
  viewModel.sweetness = .fullSugar
  return FormView(viewModel: viewModel)
}
