//
//  LayoutSupport.swift
//  CategoryPageView
//
//  Created by 양승현 on 2023/05/09.
//


import UIKit

/// UIView's layout support
protocol LayoutSupport {
  
  /// Add subviews in root view
  func addSubviews()
  
  /// Set subviews constraints in root view
  func setConstraints()
  
}

extension LayoutSupport {
  func setupUI() {
    addSubviews()
    setConstraints()
  }
}
