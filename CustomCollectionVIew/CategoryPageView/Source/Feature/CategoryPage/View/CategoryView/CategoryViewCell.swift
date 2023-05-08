//
//  CategoryViewCell.swift
//  CategoryPageView
//
//  Created by 양승현 on 2023/05/09.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
  // MARK: - Idnentfier
  static let id = "CategoryViewCell"
  
  // MARK: - Properties
  let categoryImageView = UIImageView().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .lightGray.withAlphaComponent(0.6)
    $0.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    $0.clipsToBounds = true
  }
  
  let categoryTitle = UILabel().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = UIFont.systemFont(ofSize:  CategoryViewCellConstant.Title.fontSize)
    $0.textAlignment = .center
    $0.textColor = UIColor(red: 0.404, green: 0.404, blue: 0.404, alpha: 1)
    $0.text = "카테고리"
  }
  
  override var isSelected: Bool {
    willSet {
      self.categoryTitle.textColor = newValue ? .black : UIColor(red: 0.404, green: 0.404, blue: 0.404, alpha: 1)
      self.categoryImageView.backgroundColor = newValue ? .lightGray : .lightGray.withAlphaComponent(0.6)
      newValue ? selectedAnimation() : deselectedAnimation()
      
    }
  }
  
  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    isSelected = false
    categoryImageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
  }
  
  convenience init() {
    self.init(frame: .zero)
  }
}

// MARK: - Helpers
extension CategoryViewCell {
  func configUI(
    with title: String = "카테고리",
    image: UIImage = UIImage()
  ) -> UICollectionViewCell {
    categoryImageView.image = image
    categoryTitle.text = title
    return self
  }
  
  func deselectedAnimation() {
    UIView.animate(withDuration: 0.3) {
      self.categoryImageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    }
  }
  
  func selectedAnimation() {
    UIView.animate(withDuration: 0.3) {
      self.categoryImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    }
  }
}

// MARK: - LayoutSupport
extension CategoryViewCell: LayoutSupport {
  func addSubviews() {
    _=[categoryImageView, categoryTitle]
      .map { contentView.addSubview($0) }
  }
  
  func setConstraints() {
    _=[categoryImageViewConstraint, categoryTitleConstraint]
      .map { NSLayoutConstraint.activate($0) }
  }
}

// MARK: - Subviews constraint
fileprivate extension CategoryViewCell {
  var categoryImageViewConstraint: [NSLayoutConstraint] {
    [categoryImageView.topAnchor.constraint(
      equalTo: contentView.topAnchor,
      constant: CategoryViewCellConstant.ImageView.spacingTop),
     categoryImageView.leadingAnchor.constraint(
      equalTo: contentView.leadingAnchor,
      constant: CategoryViewCellConstant.ImageView.spacingLeft),
     categoryImageView.trailingAnchor.constraint(
      equalTo: contentView.trailingAnchor,
      constant: -CategoryViewCellConstant.ImageView.spacingLeft),
     categoryImageView.heightAnchor.constraint(
      equalToConstant: CategoryViewCellConstant.ImageView.size.height)]
  }
  
  var categoryTitleConstraint: [NSLayoutConstraint] {
    [categoryTitle.topAnchor.constraint(
      equalTo: categoryImageView.bottomAnchor,
      constant: CategoryViewCellConstant.Title.spacingTop),
     categoryTitle.leadingAnchor.constraint(
      equalTo: contentView.leadingAnchor),
     categoryTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
     categoryTitle.bottomAnchor.constraint(
      equalTo: contentView.bottomAnchor,
      constant: CategoryViewCellConstant.Title.spacingBottom)]
  }
}
