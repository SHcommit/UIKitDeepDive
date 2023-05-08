//
//  CategoryDetailViewCell.swift
//  CategoryPageView
//
//  Created by 양승현 on 2023/05/09.
//

import UIKit

class CategoryDetailViewCell: UICollectionViewCell {
  // MARK: - Identifier
  static let id = "CategoryDetailViewCell"
  
  // MARK: - Properties
  let content = UIView().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
  }
  
  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  convenience init() {
    self.init(frame:.zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CategoryDetailViewCell {
  func configCell(with indexPath: IndexPath) -> UICollectionViewCell{
    backgroundColor = .systemPink
      .withAlphaComponent(CGFloat((indexPath.row+1))*0.2)
    return self
  }
}

// MARK: - LayoutSupport
extension CategoryDetailViewCell: LayoutSupport{
  func addSubviews() {
    contentView.addSubview(content)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate(contentConstraint)
  }
}

fileprivate extension CategoryDetailViewCell {
  var contentConstraint: [NSLayoutConstraint] {
    [content.topAnchor.constraint(
      equalTo: contentView.topAnchor,
      constant: CategoryDetailCellConstant.spacingTop),
     content.leadingAnchor.constraint(
      equalTo: contentView.leadingAnchor),
     content.trailingAnchor.constraint(
      equalTo: contentView.trailingAnchor),
     content.bottomAnchor.constraint(
      equalTo: contentView.bottomAnchor)]
  }
}
