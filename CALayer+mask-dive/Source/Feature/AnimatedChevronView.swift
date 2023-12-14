//
//  AnimatedChevronView.swift
//  CALayer+mask-dive
//
//  Created by 양승현 on 12/8/23.
//

import UIKit

final class AnimatedChevronView: UIView {
  // MARK: - Properties
  private let gradientLayer: CAGradientLayer = {
    $0.startPoint = CGPoint(x: 0.5, y: 0)
    $0.endPoint = CGPoint(x: 0.5, y: 1)
    $0.colors = [UIColor.black.cgColor, UIColor.white.cgColor, UIColor.black.cgColor]
    $0.locations = [0.1, 0.4, 0.9]
    return $0
  }(CAGradientLayer())
  
  private var isGradientLayerMaskSet = false
  
  // MARK: - Lifecycle
  convenience init() {
    self.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if !isGradientLayerMaskSet {
      isGradientLayerMaskSet.toggle()
      let maskLayer: CALayer = {
        $0.backgroundColor = UIColor.clear.cgColor
        $0.frame = .init(
          x: bounds.origin.x + bounds.width/2 - 14,
          y: bounds.origin.y + 20, 
          width: 28, height: 40)
        guard let image = UIImage(named: "double-chevron") else {
          print("nono")
          return .init()
        }
        $0.contents = image.cgImage
        $0.fillMode = .backwards
        return $0
      }(CALayer())
      gradientLayer.mask = maskLayer
      gradientLayer.frame = bounds
    }
  }
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 68, height: 80)
  }
  
  override func didMoveToWindow() {
    super.didMoveToWindow()
    layer.addSublayer(gradientLayer)
    let gradientAnimation: CABasicAnimation = {
      $0.fromValue = [0, 0, 0.35]
      $0.toValue   = [0.36, 1, 1]
      $0.duration  = 4
      $0.repeatCount = Float.infinity
      $0.timingFunction = CAMediaTimingFunction(name: .linear)
      return $0
    }(CABasicAnimation(keyPath: "locations"))
    gradientLayer.add(gradientAnimation, forKey: nil)
  }
}
