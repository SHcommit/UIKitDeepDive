//
//  File.swift
//  CustomPagingViewWithCollectionView
//
//  Created by 양승현 on 2023/04/03.
//

import UIKit

class FruitsTabBarCell: UICollectionViewCell {
  
  // MARK: - Properties
  var nameLabel: UILabel?
  var rectView: UIView?
  
  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    nameLabel?.text = ""
    rectView?.backgroundColor = .clear
  }
  
}

// MARK: - Helpers
extension FruitsTabBarCell {
  
  func setupUI(_ name: String, _ color: UIColor) {
    setupNameLabel(name)
    setupRectView(color)
    configureSubviews()
  }
  
}

// MARK: - ConfigureSubviewsCase
extension FruitsTabBarCell: ConfigureSubviewsCase {
  
  func configureSubviews() {
    addSubviews()
    setupSubviewsConstraints()
  }
  
  func addSubviews() { }
}

// MARK: - SetupLayouts
extension FruitsTabBarCell {
  
  func setupNameLabel(_ text: String) {
    nameLabel = UILabel().set {
      $0.text = text
      $0.textAlignment = .center
      $0.font = .systemFont(ofSize: 14)
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
  }
  
  func setupRectView(_ color: UIColor) {
    rectView = UIView().set {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.layer.cornerRadius = 12
      $0.backgroundColor = color
      $0.layer.shadowColor = color.cgColor
      $0.layer.shadowOpacity = 0.7
      $0.layer.shadowOffset = CGSize(width: 0, height: 2)
      $0.layer.shadowRadius = 3
      addSubview($0)
    }
  }
  
}

// MARK: - SetupSubviewsConstraints
extension FruitsTabBarCell: SetupSubviewsConstraints {
  
  func setupSubviewsConstraints() {
    guard let name = nameLabel,
          let rect = rectView else { return }
    NSLayoutConstraint.activate([
      rect.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
      rect.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      rect.heightAnchor.constraint(equalToConstant: 50),
      rect.widthAnchor.constraint(equalToConstant: 50)])
    NSLayoutConstraint.activate([
      name.topAnchor.constraint(equalTo: rect.bottomAnchor),
      name.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      name.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
    ])
  }
  
}
