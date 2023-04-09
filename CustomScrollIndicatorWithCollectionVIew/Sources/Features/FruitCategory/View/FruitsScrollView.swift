//
//  FruitsScrollView.swift
//  CustomPagingTabBarCategory
//
//  Created by 양승현 on 2023/04/08.
//

import UIKit

final class FruitsScrollView: UIView {
  
  // MARK: - Constraints
  private typealias ScrollConstraint = ScrollIndicatorConstraint
  
  private let ContentHeight = 3.2
  private var ContentWidth: CGFloat
  private let ScrollLeadingInset = 3.0
  private let CellSpacing = 14.0
  private var ScrollIndicatorWidth: CGFloat = 50.0
  
  // MARK: - Properties
  private lazy var scrollIndicator: UIView = UIView().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .systemOrange.withAlphaComponent(0.8)
    $0.layer.cornerRadius = 4
  }
  
  private var scrollConstraint: ScrollConstraint?
  
  var dynamicWidth: CGFloat {
    get {
      return ScrollIndicatorWidth
    }
    set {
      ScrollIndicatorWidth = newValue
    }
  }
  
  // MARK: Initialization
  private override init(frame: CGRect) {
    ContentWidth = 0
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor
      .constraint(
        equalToConstant: ContentHeight)
      .isActive = true
  }
  
  convenience init(viewWidth: CGFloat) {
    self.init(frame: .zero)
    ContentWidth = viewWidth
    configureSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - Helpers
extension FruitsScrollView {
  
  func updateScrollView(currentPosition offset: CGFloat) {
    guard offset > 0 && offset < ContentWidth - dynamicWidth else { return }
    scrollConstraint?.leading?.constant = offset + ScrollLeadingInset
    scrollConstraint?.trailing?.constant = offset + ScrollLeadingInset + dynamicWidth
  }
  
  func updateScrollViewWithDynamicWidth() {
    scrollConstraint?.width?.constant = dynamicWidth
    UIView.animate(
      withDuration: 0.3,
      delay: 0,
      options: .curveEaseIn,
      animations: { [weak self] in
        guard let self = self else { return }
        layoutIfNeeded()
      })
  }
  
}

// MARK: - FruitsScrollViewDelegate
extension FruitsScrollView: FruitsScrollViewDelegate {
  
  func didScroll(_ scrollView: UIScrollView) {
    let contentOffsetX = scrollView.contentOffset.x
    let maximumContentOffsetX = scrollView.contentSize.width - scrollView.frame.width
    let contentSizeAndSpacing = CellSpacing + dynamicWidth
    let offset = contentOffsetX * (ContentWidth - contentSizeAndSpacing) / maximumContentOffsetX
    updateScrollView(currentPosition: offset)
  }
}

// MARK: - ConfigureSubviewsCase
extension FruitsScrollView: ConfigureSubviewsCase {
  
  func configureSubviews() {
    addSubviews()
    setupSubviewsConstraints()
  }
  
  func addSubviews() {
    _=[scrollIndicator].map { addSubview($0) }
  }
  
}

// MARK: - SetupSubviewsConstraints
extension FruitsScrollView: SetupSubviewsConstraints {
  
  func setupSubviewsConstraints() {
    setupScrollIndicatorConstraints()
  }
  
  func setupScrollIndicatorConstraints() {
    let constraints = ScrollConstraint(
      top: scrollIndicator.topAnchor.constraint(
        equalTo: topAnchor, constant: 0),
      leading: scrollIndicator.leadingAnchor.constraint(
        greaterThanOrEqualTo: leadingAnchor,
        constant: ScrollLeadingInset),
      trailing: scrollIndicator.trailingAnchor.constraint(
        lessThanOrEqualTo: trailingAnchor,
        constant: -ContentWidth + dynamicWidth + ScrollLeadingInset),
      bottom: scrollIndicator.bottomAnchor.constraint(equalTo: bottomAnchor),
      width: scrollIndicator.widthAnchor.constraint(equalToConstant: dynamicWidth)
      )
    
    scrollConstraint = constraints
    _=constraints.makeList().map { $0?.isActive = true }
    
  }
  
}
