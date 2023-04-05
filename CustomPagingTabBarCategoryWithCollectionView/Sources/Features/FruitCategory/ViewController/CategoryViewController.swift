//
//  CategoryViewController.swift
//  CustomPagingViewWithCollectionView
//
//  Created by 양승현 on 2023/04/03.
//

import UIKit
import Combine

final class CategoryViewController: UIViewController {
  lazy var customTabBarView = CustomTabBarScrollableView()
  let spaceView = {
    return UIView().setup{
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    configureSubviews()
  }
}

//MARK: - Helpers
extension CategoryViewController {
  func setupUI() {
    view.backgroundColor = .white
  }
}

//MARK: - ConfigureSubviewCase
extension CategoryViewController: ConfigureSubviewsCase {
  
  func configureSubviews() {
    addSubviews()
    setupSubviewsConstraints()
  }
  
  func addSubviews() {
    _=[customTabBarView,spaceView].map{view.addSubview($0)}
  }
  
}

//MARK: - SetupSubviewsConstraints
extension CategoryViewController: SetupSubviewsConstraints {
  
  func setupSubviewsConstraints() {
    setupCustomTabBarViewConstraints()
    setupSpaceConstraints()
  }
  
  func setupCustomTabBarViewConstraints() {
    NSLayoutConstraint.activate([
      customTabBarView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor),
      customTabBarView.leadingAnchor.constraint(
        equalTo: view.leadingAnchor),
      customTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      customTabBarView.heightAnchor.constraint(equalToConstant: 50+7+17+7)
    ])
  }
  
  func setupSpaceConstraints() {
    NSLayoutConstraint.activate([
      spaceView.topAnchor.constraint(equalTo: customTabBarView.bottomAnchor),
      spaceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      spaceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      spaceView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
}
