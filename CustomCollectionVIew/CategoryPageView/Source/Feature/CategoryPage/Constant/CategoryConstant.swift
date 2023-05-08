//
//  CategoryViewUIConstraints.swift
//  CategoryPageView
//
//  Created by 양승현 on 2023/05/09.
//

import UIKit

// MARK: - CategoryView UI constants
struct CategoryViewConstant {
  
  /// Size얻기 위해 사용되는 인스턴스
  static var shared = CategoryViewConstant()
  
  /// CategoryViewCellUIConstants
  var cellSize: CGSize {
    CategoryViewCellConstant.shared.cellSize
  }
  
  /// height = cell height + scrollBar height.
  var intrinsicContentSize: CGSize  {
    let width = cellSize.width
    let height = cellSize.height + CategoryViewConstant.ScrollBar.height
    return CGSize(width: width, height: height)
  }
  
  enum ScrollBar {
    static let height: CGFloat = 4
    static let radius: CGFloat = 3
  }
  
  fileprivate init() {}
  
}

// MARK: - CategoryViewCell UI constants
struct CategoryViewCellConstant {
  /// content size얻고 싶을 때.
  static var shared = CategoryViewCellConstant()
  
  enum ImageView {
    static let spacingTop: CGFloat = 20
    static let spacingLeft: CGFloat = 27.5
    static let size: CGSize = CGSize(width: 28, height: 28)
  }
  enum Title {
    static let spacingTop: CGFloat = 5
    static let fontSize: CGFloat = 12
    static let spacingBottom: CGFloat = 6
    static let height: CGFloat = 22
  }
  
  var cellSize: CGSize {
    CGSize(
      width: CategoryViewCellConstant.shared.cellWidth,
      height: CategoryViewCellConstant.shared.cellHeight)
  }
  
  /// Cell's intrinsic content width
  fileprivate lazy var cellWidth: CGFloat = {
    return ImageView.spacingLeft*2.0 + ImageView.size.width
  }()
  
  /// Cell's intrinsic content height
  fileprivate lazy var cellHeight: CGFloat = {
    return (
      ImageView.spacingTop +
      ImageView.size.height +
      Title.spacingTop +
      Title.height +
      Title.spacingBottom)
  }()

  fileprivate init() {}
}


// MARK: - CategoryDetailViewCell UI constants
struct CategoryDetailCellConstant {
  static let spacingTop: CGFloat = 17.5
  
  fileprivate init() {}
}
