//
//  ViewPoint.swift
//  NTUiOSClub
//
//  Created by ethanhuang on 2025/10/12.
//

enum ViewPoint: CaseIterable {
  case top
  case side
  case bottom
}

extension ViewPoint {
  var title: String {
    switch self {
    case .top:
      "Top"
    case .side:
      "Side"
    case .bottom:
      "Bottom"
    }
  }

  var degrees: Double {
    switch self {
    case .top:
      0
    case .side:
      90
    case .bottom:
      180
    }
  }
}
