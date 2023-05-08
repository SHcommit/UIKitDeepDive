//
//  ViewController.swift
//  CategoryPageView
//
//  Created by 양승현 on 2023/05/09.
//

import UIKit

class ViewController: UIViewController {
  // MARK: - Properties
  let categoryPageView = CategoryPageView()
  
  // MARK: - Lifeclcye
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    view.backgroundColor = .yellow
  }
}

// MARK: - LayoutSupport
extension ViewController: LayoutSupport {
  func addSubviews() {
    view.addSubview(categoryPageView)
  }
  
  func setConstraints() {
    NSLayoutConstraint.activate(categoryPageViewConstraint)
  }
}

fileprivate extension ViewController {
  var categoryPageViewConstraint: [NSLayoutConstraint] {
    [categoryPageView.topAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.topAnchor),
     categoryPageView.leadingAnchor.constraint(
      equalTo: view.leadingAnchor),
     categoryPageView.trailingAnchor.constraint(
      equalTo: view.trailingAnchor),
     categoryPageView.bottomAnchor.constraint(
      equalTo: view.safeAreaLayoutGuide.bottomAnchor)]
  }
}
