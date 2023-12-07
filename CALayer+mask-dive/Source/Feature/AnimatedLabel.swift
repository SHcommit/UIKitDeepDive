//
//  AnimatedLabel.swift
//  CALayer+mask-dive
//
//  Created by 양승현 on 12/8/23.
//

import UIKit

final class AnimatedLabel: UILabel {
  // MARK: - Properties
  private let gradientLayer: CAGradientLayer = {
    $0.startPoint = .init(x: 0, y: 0.5)
    $0.endPoint = .init(x: 1, y: 0.5)
    $0.colors = [UIColor.black.cgColor, UIColor.white.cgColor, UIColor.black.cgColor]
    $0.locations = [0.15, 0.5, 0.85]
    return $0
  }(CAGradientLayer())
  
  private let textAttributes = {
    let style = NSMutableParagraphStyle()
    style.alignment = .center
    return [
      .font: UIFont.systemFont(ofSize: 25, weight: .light),
      .paragraphStyle: style
    ] as [NSAttributedString.Key: Any]
  }()
  
  override var text: String? {
    didSet {
      attributedText = NSAttributedString(string: text ?? "", attributes: textAttributes)
    }
  }
  
  convenience init() {
    self.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  // MARK: - Lifecycle
  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = CGRect(
      x: -bounds.size.width, y: bounds.origin.y,
      width: bounds.size.width*3, height: bounds.size.height)
    let maskLayer = CALayer()
    maskLayer.backgroundColor = UIColor.clear.cgColor
    maskLayer.frame = bounds.offsetBy(dx: bounds.size.width, dy: 0)
    let image = UIGraphicsImageRenderer(size: bounds.size)
      .image { _ in
        (attributedText ?? .init(string: "")).draw(in: bounds)
      }
    maskLayer.contents = image.cgImage
    gradientLayer.mask = maskLayer
  }
  
  override func didMoveToWindow() {
    super.didMoveToWindow()
    layer.addSublayer(gradientLayer)
    let gradientAnimation: CABasicAnimation = {
      $0.fromValue = [0,0,0.35]
      $0.toValue = [0.65, 1, 1]
      $0.duration = 5
      $0.repeatCount = Float.infinity
      return $0
    }(CABasicAnimation(keyPath: "locations"))
    gradientLayer.add(gradientAnimation, forKey: nil)
  }
}
