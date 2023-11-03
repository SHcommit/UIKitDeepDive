//
//  PetCell.swift
//  DynamicTableViewCellWithAnimation
//
//  Created by 양승현 on 11/4/23.
//

import UIKit

final class PetCell: UITableViewCell {
  // MARK: - Constant
  static let id = String(describing: PetCell.self)
  
  // MARK: - Properties
  private let thumbnailView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 8
    return $0
  }(UIImageView())
  
  private let titleLabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 15, weight: .medium)
    $0.numberOfLines = 1
    return $0
  }(UILabel())
  
  private lazy var chevronImageView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentMode = .scaleAspectFit
    $0.image = UIImage(named: "chevronDown")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
    return $0
  }(UIImageView(frame: .zero))
  
  private let expendableLabel: PaddingLabel = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.font = .systemFont(ofSize: 13, weight: .regular)
    $0.numberOfLines = 0
    $0.layer.cornerRadius = 7
    $0.clipsToBounds = true
    $0.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 0.55)
    return $0
  }(PaddingLabel())
  
  private var isExpendableLabelShadowSet = false
  
  private var notExpendedConstraints: [NSLayoutConstraint] = []
  
  private var expendedConstraints: [NSLayoutConstraint] = []
  
  weak var delegate: PetCellDelegate?
  
  var isExpended: Bool = false {
    didSet {
      updateVisibleLayout()
      updateUIState()
      updateChevronRotation()
    }
  }
  
  // MARK: - Lifecycles
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    nil
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    configure(with: nil)
  }
}

// MARK: - Helpers
extension PetCell {
  func configure(with info: PetInfo?) {
    titleLabel.text = info?.title
    titleLabel.sizeToFit()
    expendableLabel.text = info?.details
    expendableLabel.sizeToFit()
    isExpended = info?.isExpended ?? false
    if isExpended {
      titleLabel.alpha = 1
      expendableLabel.alpha = 1
    }
    guard let thumbnailPath = info?.thumbnailPath else {
      thumbnailView.image = nil
      return
    }
    thumbnailView.image = UIImage(named: thumbnailPath)
  }
  
  func animateUIForExpendedState() {
    guard isExpended else { return }
    prepareUIForExpendedStateAnimation()
    
    UIView.animate(
      withDuration: 0.28,
      delay: 0,
      options: [.curveEaseOut],
      animations: { [unowned self] in
        titleLabel.alpha = 1
        titleLabel.transform = .identity
      })
    UIView.animate(
      withDuration: 0.28,
      delay: 0.22,
      options: [.curveEaseOut],
      animations: { [unowned self] in
        expendableLabel.transform = .identity
        expendableLabel.alpha = CGFloat(isExpended.toInt)
      })
  }
}

// MARK: - Private Helpers
private extension PetCell {
  func configureUI() {
    setupUI()
    selectionStyle = .none
  }
  
  func updateVisibleLayout() {
    if isExpended {
      NSLayoutConstraint.deactivate(notExpendedConstraints)
      NSLayoutConstraint.activate(expendedConstraints)
    } else {
      NSLayoutConstraint.deactivate(expendedConstraints)
      NSLayoutConstraint.activate(notExpendedConstraints)
    }
  }
  
  func updateChevronRotation() {
    if isExpended {
      chevronImageView.transform = .init(rotationAngle: .pi)
    } else {
      chevronImageView.transform = .identity
    }
  }
  
  func updateUIState() {
    guard isExpended else {
      titleLabel.alpha = 1
      expendableLabel.alpha = CGFloat(isExpended.toInt)
      return
    }
    titleLabel.alpha = 0
    expendableLabel.alpha = 0
  }
  
  func prepareUIForExpendedStateAnimation() {
    titleLabel.alpha = 0
    titleLabel.transform = .init(translationX: -titleLabel.bounds.width/10*1, y: 0)
    expendableLabel.transform = .init(
      translationX: 0,
      y: -CGFloat(CGFloat(expendableLabel.lines) * expendableLabel.font.lineHeight/4.0))
  }
}

// MARK: - Layout subviews
private extension PetCell {
  typealias Constraint = NSLayoutConstraint
  
  func setupUI() {
    addSubviews()
    setConstraints()
  }
  
  func addSubviews() {
    _=[
      thumbnailView,
      titleLabel,
      chevronImageView,
      expendableLabel
    ].map {
      contentView.addSubview($0)
    }
  }
  
  func setConstraints() {
    notExpendedConstraints = notExpendedStateConstraints
    expendedConstraints = expendedStateConstraints
    
    _=[defaultConstraints + notExpendedConstraints].map {
      NSLayoutConstraint.activate($0)
    }
  }
  
  var notExpendedStateConstraints: [Constraint] {
    let thumbnailViewBottomConstraint = thumbnailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7)
    thumbnailViewBottomConstraint.priority = .defaultHigh
    return [
      thumbnailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
      thumbnailViewBottomConstraint,
      thumbnailView.widthAnchor.constraint(equalToConstant: 50),
      thumbnailView.heightAnchor.constraint(equalToConstant: 50),
      
      chevronImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      
      titleLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 7),
      titleLabel.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 7),
      titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -7),
      titleLabel.centerYAnchor.constraint(equalTo: thumbnailView.centerYAnchor)]
  }
  
  var expendedStateConstraints: [Constraint] {
    let thumbnailViewBottomConstraint = thumbnailView.bottomAnchor.constraint(
      lessThanOrEqualTo: contentView.bottomAnchor,
      constant: -7)
    thumbnailViewBottomConstraint.priority = .defaultHigh
    return [
      titleLabel.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 7),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
      chevronImageView.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 7),
      
      thumbnailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
      thumbnailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
      thumbnailView.heightAnchor.constraint(equalToConstant: 125),
      
      chevronImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      
      expendableLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)]
  }
  
  var defaultConstraints: [Constraint] {
    let expendableLabelBottomConstraint = expendableLabel.bottomAnchor.constraint(
      equalTo: contentView.bottomAnchor,
      constant: -7)
    
    expendableLabelBottomConstraint.priority = .defaultHigh
    
    return [
      thumbnailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
      
      expendableLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
      expendableLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
      expendableLabelBottomConstraint,
      
      titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -(14+24)),
      chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
      chevronImageView.widthAnchor.constraint(equalToConstant: 24),
      chevronImageView.heightAnchor.constraint(equalToConstant: 24)]
  }
}
