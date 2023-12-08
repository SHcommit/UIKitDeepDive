//
//  ViewController.swift
//  CALayer+mask-dive
//
//  Created by 양승현 on 12/7/23.
//

import UIKit

class ViewController: UIViewController {
  override func loadView() {
    super.loadView()
    view.backgroundColor = .systemCyan
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    let chevronView = AnimatedChevronView()
    let label = AnimatedLabel()
    label.text = "GRADIENT WITH MASK"
    [chevronView, label].forEach(view.addSubview(_:))
    NSLayoutConstraint.activate([
      chevronView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      chevronView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),
      label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -300),
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor)]) 
  }
}

