//
//  ViewController.swift
//  Example-LayoutIfNeeded
//
//  Created by 양승현 on 12/14/23.
//

import UIKit

class ViewController: UIViewController {
  private var bottomConstraint: NSLayoutConstraint!
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .yellow
    let button = UIButton(primaryAction: .init(handler: { [weak self] _ in
      self?.showCardView()
    }))
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Show card view", for: .normal)
    view.addSubview(button)
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
  }
  
  func showCardView() {
    let dynamicCardView = RotationCardView()
    view.addSubview(dynamicCardView)
    bottomConstraint = dynamicCardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 250)
    NSLayoutConstraint.activate([
      dynamicCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      bottomConstraint])
    view.layoutIfNeeded()
    dynamicCardView.setImageLayer(with: dynamicCardView.bounds)
    UIView.animate(
      withDuration: 0.8,
      delay: 0,
      usingSpringWithDamping: 0.4,
      initialSpringVelocity: 0,
      animations: {
        self.bottomConstraint.constant = -50
        self.view.layoutIfNeeded()
      }, completion: { _ in
        dynamicCardView.setGradientLabel()
      })
  }
}
