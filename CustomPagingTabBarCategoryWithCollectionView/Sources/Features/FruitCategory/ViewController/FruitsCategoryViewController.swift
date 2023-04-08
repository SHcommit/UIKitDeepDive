//
//  CategoryViewController.swift
//  CustomPagingViewWithCollectionView
//
//  Created by 양승현 on 2023/04/03.
//

import UIKit
import Combine

final class FruitsCategoryViewController: UIViewController {
  
  lazy var fruitsTabBarView = FruitsTabBarScrollableView(
    fruitsTabBarWidth: view.bounds.width)
  
  let spaceView = {
    return UIView().set {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    configureSubviews()
    self.navigationController?.navigationBar.backgroundColor = .yellow
  }
  
}

// MARK: - Helpers
extension FruitsCategoryViewController {
  
  func setupUI() {
    view.backgroundColor = .white
  }
  
}

// MARK: - ConfigureSubviewCase
extension FruitsCategoryViewController: ConfigureSubviewsCase {
  
  func configureSubviews() {
    addSubviews()
    setupSubviewsConstraints()
  }
  
  func addSubviews() {
    _=[fruitsTabBarView, spaceView].map { view.addSubview($0) }
  }
  
}

// MARK: - SetupSubviewsConstraints
extension FruitsCategoryViewController: SetupSubviewsConstraints {
  
  func setupSubviewsConstraints() {
    setupCustomTabBarViewConstraints()
    setupSpaceConstraints()
  }
  
  func setupCustomTabBarViewConstraints() {
    NSLayoutConstraint.activate([
      fruitsTabBarView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor),
      fruitsTabBarView.leadingAnchor.constraint(
        equalTo: view.leadingAnchor),
      fruitsTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      fruitsTabBarView.heightAnchor.constraint(equalToConstant: 50+7+17+7+4+3.2)
    ])
  }
  
  func setupSpaceConstraints() {
    NSLayoutConstraint.activate([ spaceView.topAnchor.constraint(equalTo: fruitsTabBarView.bottomAnchor, constant: 4),
      spaceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      spaceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      spaceView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
  }
  
}
