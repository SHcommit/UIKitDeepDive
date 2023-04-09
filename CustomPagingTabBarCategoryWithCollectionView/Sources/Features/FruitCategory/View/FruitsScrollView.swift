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
  
  private let FruitsScrollViewHeight = 3.2
  private let ScrollLeadingInset = 3.0
  private let FruitsCellSpacing = 14.0
  private var FruitsViewWidth: CGFloat
  private var FruitsScrollViewWidth: CGFloat = 50.0
  
  // MARK: - Properties
  private let background = UIView().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .lightGray.withAlphaComponent(0.2)
  }
  private lazy var scrollIndicator: UIView = UIView().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .gray
    $0.layer.cornerRadius = 4
  }
  private var scrollConstraint: ScrollConstraint?
  
  var dynamicWidth: CGFloat {
    get {
      return FruitsScrollViewWidth
    }
    set {
      FruitsScrollViewWidth = newValue
    }
  }
  
  // MARK: Initialization
  private override init(frame: CGRect) {
    FruitsViewWidth = 0
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor
      .constraint(
        equalToConstant: FruitsScrollViewHeight)
      .isActive = true
  }
  
  convenience init(viewWidth: CGFloat) {
    self.init(frame: .zero)
    FruitsViewWidth = viewWidth
    configureSubviews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - Helpers
extension FruitsScrollView {
  
  func updateScrollView(currentPosition offset: CGFloat) {
    guard offset>0 &&
          offset < FruitsViewWidth - dynamicWidth - FruitsCellSpacing + ScrollLeadingInset else { return }
    
    if offset == 0.0 {
      // 초기 spacing
      scrollConstraint?.leading?.constant = ScrollLeadingInset
    } else {
      scrollConstraint?.leading?.constant = offset + ScrollLeadingInset
    }
    scrollConstraint?.trailing?.constant = -FruitsViewWidth + offset + dynamicWidth + FruitsCellSpacing/2
  }
  
  func updateScrollView(dynamicWidth width: CGFloat, offset: CGFloat) {
//    scrollConstraint?.leading?.constant = offset + ScrollLeadingInset
//    scrollConstraint?.trailing?.constant = -FruitsViewWidth + offset + dynamicWidth + FruitsCellSpacing/2
    scrollConstraint?.width?.constant = width
    UIView.animate(
      withDuration: 0.2,
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
    guard contentOffsetX > 0.0 && contentOffsetX < maximumContentOffsetX else {
      return
    }
    let contentSizeAndSpacing = FruitsCellSpacing + FruitsScrollViewWidth
    let offset = contentOffsetX * (FruitsViewWidth - contentSizeAndSpacing) / maximumContentOffsetX
    /// 이걸 통해서 스크롤 뷰가 이동하는것 표시함.
    updateScrollView(currentPosition: offset)
    print(offset)
    /// 이제 남은건 스크롤 뷰의 사이즈임.
    if offset < 50 && offset >= 0 {
      dynamicWidth = 20
      updateScrollView(dynamicWidth: dynamicWidth, offset: offset)
    } else if offset < 150 && offset >= 50 {
      dynamicWidth = 30
      updateScrollView(dynamicWidth: dynamicWidth, offset: offset)
    } else if offset < 250 && offset >= 150 {
      dynamicWidth = 60
      updateScrollView(dynamicWidth: dynamicWidth, offset: offset)
    }
  }
}

// MARK: - ConfigureSubviewsCase
extension FruitsScrollView: ConfigureSubviewsCase {
  
  func configureSubviews() {
    addSubviews()
    setupSubviewsConstraints()
  }
  
  func addSubviews() {
    _=[background, scrollIndicator].map { addSubview($0) }
    bringSubviewToFront(scrollIndicator)
  }
  
}

// MARK: - SetupSubviewsConstraints
extension FruitsScrollView: SetupSubviewsConstraints {
  
  func setupSubviewsConstraints() {
    setupBackgroundConstraints()
    setupScrollViewConstraints()
  }
  
  func setupBackgroundConstraints() {
    NSLayoutConstraint.activate([
      background.topAnchor.constraint(equalTo: topAnchor),
      background.leadingAnchor.constraint(equalTo: leadingAnchor),
      background.trailingAnchor.constraint(equalTo: trailingAnchor),
      background.bottomAnchor.constraint(equalTo: bottomAnchor)])
  }
  
  func setupScrollViewConstraints() {
    let constraints = ScrollConstraint(
      top: scrollIndicator.topAnchor.constraint(
        equalTo: topAnchor, constant: 0),
      leading: scrollIndicator.leadingAnchor.constraint(
        greaterThanOrEqualTo: leadingAnchor,
        constant: ScrollLeadingInset),
      trailing: scrollIndicator.trailingAnchor.constraint(
        lessThanOrEqualTo: trailingAnchor,
        constant: -FruitsViewWidth + dynamicWidth + FruitsCellSpacing/2 ),
      bottom: scrollIndicator.bottomAnchor.constraint(equalTo: bottomAnchor),
      width: scrollIndicator.widthAnchor.constraint(equalToConstant: 50)
      )
    scrollConstraint = constraints
    _=constraints.makeList().map { $0?.isActive = true }
    
  }
  
}
