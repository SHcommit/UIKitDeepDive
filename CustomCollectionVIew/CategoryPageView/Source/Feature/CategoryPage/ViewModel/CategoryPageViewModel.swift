//
//  CategoryPageViewModel.swift
//  CategoryPageView
//
//  Created by 양승현 on 2023/05/09.
//

import UIKit

struct CategoryPageViewModel {
  let data = categoryData
}

// MARK: - Helpers
extension CategoryPageViewModel {
  /// Return categoryView cell's title font size
  /// - Parameter index: 특정 cell의 indexPath
  /// - Returns: 특정 cell의 sizeToFit된 width 길이
  func titleFontSize(
    of index: IndexPath = IndexPath(row: 0, section: 0)
  ) -> CGFloat {
    let lb = UILabel()
    lb.text = data[index.row]
    lb.font = UIFont.systemFont(ofSize:  CategoryViewCellConstant.Title.fontSize)
    lb.sizeToFit()
    return lb.bounds.width
  }
  
  /// Return scrollBar specific position's leading spacing
  /// - Parameter titleWidth: 특정 categoryViewCell의 title 실제 길이
  /// - Returns: cell에서 title을 제외한 영역중 절반 leading spacing
  func scrollBarLeadingSpacing(_ titleWidth: CGFloat) -> CGFloat {
    return (
      CategoryViewConstant
        .shared
        .intrinsicContentSize
        .width - titleWidth)/2.0
  }
  
  func configCell(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath,
    type: CategoryViewType
  ) -> UICollectionViewCell {
    switch type {
    case .categoryDetail:
      return setupCategoryDetailCell(
        collectionView,
        cellForItemAt: indexPath)
    default:
      return setupCategoryCell(
        collectionView,
        cellForItemAt: indexPath)
    }
  }
}

// MARK: - Fileprivate helpers
fileprivate extension CategoryPageViewModel {
  func setupCategoryCell(
    _ cv: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = cv.dequeueReusableCell(
      withReuseIdentifier: CategoryViewCell.id,
      for: indexPath
    ) as? CategoryViewCell else {
      return UICollectionViewCell()
    }
    return cell.configUI(with: data[indexPath.row])
  }
  
  func setupCategoryDetailCell(
    _ cv: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = cv.dequeueReusableCell(
      withReuseIdentifier: CategoryDetailViewCell.id,
      for: indexPath
    ) as? CategoryDetailViewCell else {
      return UICollectionViewCell()
    }
    return cell.configCell(with: indexPath)
  }
}
