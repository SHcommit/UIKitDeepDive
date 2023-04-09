//
//  ScrollIndicatorConstraint.swift
//  CustomPagingTabBarCategory
//
//  Created by 양승현 on 2023/04/09.
//

import UIKit

struct ScrollIndicatorConstraint {
  var top: NSLayoutConstraint?
  var leading: NSLayoutConstraint?
  var trailing: NSLayoutConstraint?
  var bottom: NSLayoutConstraint?
  var width: NSLayoutConstraint?
  
  func makeList() -> [NSLayoutConstraint?] {
    return [top, leading, trailing, bottom, width]
  }
}
