//
//  bluredLabel.swift
//  Example-LayoutIfNeeded
//
//  Created by 양승현 on 12/14/23.
//

import UIKit

final class GradientAnimatedLabel: UILabel {
  private let padding = UIEdgeInsets(top: 7, left: 14, bottom: 7, right: 14)
  
  private let gradientLayer: CAGradientLayer = {
    $0.startPoint = .init(x: 0 , y: 0.15)
    $0.endPoint = .init(x: 1, y: 0.85)
    $0.colors = [
      UIColor.systemOrange.cgColor,
      UIColor.systemMint.cgColor,
      UIColor.systemOrange.cgColor]
    $0.locations = [0.15, 0.5, 0.85]
    return $0
  }(CAGradientLayer())
  
  private let textAttributes = {
    let style = NSMutableParagraphStyle()
    style.alignment = .center
    return [
      .font: UIFont.systemFont(ofSize: 15, weight: .light),
      .paragraphStyle: style
    ] as [NSAttributedString.Key: Any]
  }()
  
  override var text: String? {
    didSet {
      attributedText = NSAttributedString(string: text ?? "", attributes: textAttributes)
    }
  }
  
  override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(
      width: size.width + padding.left + padding.right,
      height: size.height + padding.bottom + padding.top)
  }
  
  // MARK: - Lifecycle
  convenience init() {
    self.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    layer.backgroundColor = UIColor.white.cgColor
    layer.cornerRadius = 10
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    print("\(Self.self) updateConstriants called")
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    print("\(Self.self) draw called")
  }
  
  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: padding))
  }
  
  override func layoutIfNeeded() {
    super.layoutIfNeeded()
    print("GradientAnimatedLabel's layoutIfNeeded calls")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    print("GradientAnimatedLabel layoutSubviews")
    gradientLayer.frame = CGRect(
      x: -bounds.size.width, y: bounds.origin.y,
      width: bounds.size.width*3, height: bounds.size.height)
    let maskLayer = CALayer()
    maskLayer.backgroundColor = UIColor.clear.cgColor
    maskLayer.frame = bounds.offsetBy(dx: bounds.size.width, dy: padding.top)
    let image = UIGraphicsImageRenderer(size: bounds.size).image { _ in
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
