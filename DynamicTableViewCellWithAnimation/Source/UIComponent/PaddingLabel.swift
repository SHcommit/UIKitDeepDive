//
//  PaddingLabel.swift
//  DynamicTableViewCellWithAnimation
//
//  Created by 양승현 on 11/4/23.
//

import UIKit

final class PaddingLabel: UILabel {
  private var padding: UIEdgeInsets  = .init(top: 7, left: 7, bottom: 7, right: 7)
  
  private var isBoundsSet = false
  
  // MARK: - Lifecycles
  convenience init(padding: UIEdgeInsets) {
    self.init()
    self.padding = padding
  }
  
  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: padding))
  }
  
  override var intrinsicContentSize: CGSize {
    return .init(
      width: super.intrinsicContentSize.width + padding.left + padding.right,
      height: super.intrinsicContentSize.height + padding.top + padding.bottom)
  }
  
  var lines: Int {
    if bounds == .zero { return 0 }
    return Int((bounds.height - (padding.top + padding.bottom))/font.lineHeight)
  }
}

