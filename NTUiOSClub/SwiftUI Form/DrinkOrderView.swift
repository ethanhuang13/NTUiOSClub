import SwiftUI

struct FormView: View {
  @State private var viewModel = DrinkOrderViewModel()

  init(viewModel: DrinkOrderViewModel = DrinkOrderViewModel()) {
    _viewModel = State(initialValue: viewModel)
  }

  var body: some View {
    NavigationStack {
      Form {
        Section("點餐人") {
          nameTextField
        }

        Section("甜度") {
          sweetnessPicker
          sweetnessSlider
        }

        Section("冰塊") {
          iceLevelPicker
          iceLevelSlider
        }

        Section("其他") {
          wantsBobaToggle
        }

        Section("尺寸與數量") {
          sizePicker
          cupCountStepper
        }

        Section("取餐時間") {
          pickupTimePicker
        }

        Section("訂單摘要") {
          orderSummaryText
        }
      }
      .navigationTitle("點飲料表單")
      .navigationBarTitleDisplayMode(.inline)
    }
  }

  @ViewBuilder
  private var nameTextField: some View {
    TextField("輸入姓名", text: $viewModel.customerName)
      .textInputAutocapitalization(.words)
  }

  @ViewBuilder
  private var sweetnessPicker: some View {
    Picker("甜度", selection: $viewModel.sweetness) {
      ForEach(DrinkOrderViewModel.Sweetness.allCases) { sweetness in
        Text(sweetness.rawValue)
          .tag(sweetness)
      }
    }
    .pickerStyle(.segmented)

    Picker("甜度", selection: $viewModel.sweetness) {
      ForEach(DrinkOrderViewModel.Sweetness.allCases) { sweetness in
        Text(sweetness.rawValue)
          .tag(sweetness)
      }
    }
    .pickerStyle(.menu)  // 可以換成別的
  }

  @ViewBuilder
  private var sweetnessSlider: some View {
    Slider(
      value: Binding(
        get: { viewModel.sweetnessSliderValue },
        set: { value in
          viewModel.sweetnessSliderValue = value
        }
      ),
      in: 0...1.0,
      step: 0.25
    ) {
      Text("甜度")
    } minimumValueLabel: {
      Text("無糖")
    } maximumValueLabel: {
      Text("全糖")
    }

    Slider(
      value: Binding(
        get: { viewModel.sweetnessSliderValue },
        set: { value in
          viewModel.sweetnessSliderValue = value
        }
      ),
      in: 0...1.0,
      step: 0.25
    ) {
      Text("甜度")
    } minimumValueLabel: {
      Text("無糖")
    } maximumValueLabel: {
      Text("全糖")
    }
    .sliderThumbVisibility(.hidden)
  }

  @ViewBuilder
  private var iceLevelPicker: some View {
    Picker(
      "冰塊",
      selection: Binding(
        get: { viewModel.iceOption },
        set: { viewModel.iceOption = $0 }
      )
    ) {
      ForEach(DrinkOrderViewModel.IceLevelOption.allCases) { iceOption in
        Text(iceOption.rawValue)
          .tag(iceOption)
      }
    }
    .pickerStyle(.navigationLink)  // 可以換成別的
  }

  @ViewBuilder
  private var iceLevelSlider: some View {
    Slider(
      value: $viewModel.iceLevel,
      in: 0...1.0,
      step: 0.25
    )
  }

  @ViewBuilder
  private var wantsBobaToggle: some View {
    Toggle(viewModel.wantsBoba ? "加珍珠" : "不加珍珠", isOn: $viewModel.wantsBoba)

    Toggle("\(viewModel.wantsBoba ? "" : "不")加珍珠", isOn: $viewModel.wantsBoba)

    Toggle(isOn: $viewModel.wantsBoba) {
      Label {
        Text(viewModel.wantsBoba ? "加珍珠" : "不加珍珠")
      } icon: {
        Image(systemName: "leaf.fill")
      }
    }
    .toggleStyle(.button)
  }

  @ViewBuilder
  private var sizePicker: some View {
    Picker("杯型", selection: $viewModel.size) {
      ForEach(DrinkOrderViewModel.DrinkSize.allCases) { size in
        Text(size.rawValue)
          .tag(size)
      }
    }
    .pickerStyle(.segmented)
  }

  @ViewBuilder
  private var cupCountStepper: some View {
    Stepper(
      "\(viewModel.cupCount)杯",
      value: $viewModel.cupCount,
      in: 1...13,
    )

    Stepper(value: $viewModel.cupCount, in: 1...13) {
      Label(
        "\(viewModel.cupCount)杯",
        systemImage: "cup.and.saucer.fill"
      )
    }
  }

  @ViewBuilder
  private var pickupTimePicker: some View {
    DatePicker(
      "預計取餐",
      selection: $viewModel.pickupTime,
      in: Date.now...,
      displayedComponents: [.date, .hourAndMinute]
    )
    .datePickerStyle(.compact)
  }

  @ViewBuilder
  private var orderSummaryText: some View {
    Text(viewModel.orderSummary)
      .font(.subheadline)
      .foregroundStyle(.secondary)
  }
}

extension DrinkOrderViewModel {
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

#Preview("預設") {
  FormView()
}

#Preview("大杯無糖少冰奶茶 x 2") {
  let viewModel = DrinkOrderViewModel()
  viewModel.customerName = "13"
  viewModel.wantsBoba = false
  viewModel.cupCount = 2
  viewModel.iceLevel = 0.5
  viewModel.size = .large
  viewModel.sweetness = .noSugar
  return FormView(viewModel: viewModel)
}

#Preview("13 大杯全糖全冰訂單") {
  let viewModel = DrinkOrderViewModel()
  viewModel.customerName = "iOS Club"
  viewModel.wantsBoba = true
  viewModel.cupCount = 13
  viewModel.iceLevel = 1.0
  viewModel.size = .large
  viewModel.sweetness = .fullSugar
  return FormView(viewModel: viewModel)
}
