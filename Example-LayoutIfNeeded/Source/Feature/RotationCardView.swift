//
//  RotationCard.swift
//  Example-LayoutIfNeeded
//
//  Created by 양승현 on 12/14/23.
//

import UIKit

final class RotationCardView: UIView {
  // MARK: - Properties
  private let imageLayer: CALayer = {
    $0.contents = UIImage(named: "cute_cat")!.cgImage
    $0.cornerRadius = 10
    $0.masksToBounds = true
    return $0
  }(CALayer())
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.addSublayer(imageLayer)
    setRotationAnimation()
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    print("\(Self.self) updateConstriants called")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    print("RotationCardView LayoutSubviews called")
  }
  
  convenience init() {
    self.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    print("\(Self.self) draw called")
  }
  
  required init?(coder: NSCoder) { nil }
  
  override var intrinsicContentSize: CGSize {
    return CGSize(width: 200, height: 200)
  }
  
  // MARK: - Helpers
  func setGradientLabel() {
    let gradientLabel = GradientAnimatedLabel()
    let minimumTopSpacing = 5.0
    gradientLabel.text = "# 귀여운 고양이 카드"
    gradientLabel.alpha = 0
    addSubview(gradientLabel)
    let gradientLabelBottomConstraint = gradientLabel.topAnchor.constraint(
      equalTo: bottomAnchor,
      constant: minimumTopSpacing - gradientLabel.intrinsicContentSize.height/2)
    NSLayoutConstraint.activate([
      gradientLabelBottomConstraint,
      gradientLabel.trailingAnchor.constraint(equalTo: trailingAnchor)])
    self.layoutIfNeeded()
    UIView.animate(withDuration: 0.2, animations: {
      gradientLabelBottomConstraint.constant = minimumTopSpacing
      gradientLabel.alpha = 1
      self.layoutIfNeeded()
    })
  }
  
  private func setRotationAnimation() {
    let rotationAnimation: CABasicAnimation = {
      $0.fromValue = -Double.pi/2
      $0.toValue = 0
      $0.duration = 0.3
      $0.timingFunction = CAMediaTimingFunction(name: .easeOut)
      return $0
    }(CABasicAnimation(keyPath: "transform.rotation"))
    layer.add(rotationAnimation, forKey: nil)
  }
  
  func setImageLayer(with frame: CGRect) {
    self.imageLayer.frame = frame
  }
}
