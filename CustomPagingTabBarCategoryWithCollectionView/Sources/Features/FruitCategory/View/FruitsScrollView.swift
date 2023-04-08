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
  private var FruitsViewWidth: CGFloat
  private var FruitsScrollViewWidth: CGFloat = 40.0 {
    didSet {
      updateScrollView(dynamicWidth: dynamicWidth)
    }
  }
  
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
      return FruitsViewWidth
    }
    set {
      FruitsViewWidth = newValue
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
    guard offset>=0 &&
          offset<=FruitsViewWidth else { return }
    NSLayoutConstraint.activate([
      scrollIndicator.topAnchor.constraint(equalTo: topAnchor),
      scrollIndicator.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
      scrollIndicator.trailingAnchor.constraint(
        lessThanOrEqualTo: trailingAnchor,
        constant: -FruitsViewWidth + offset + dynamicWidth ),
      scrollIndicator.bottomAnchor.constraint(equalTo: bottomAnchor),
      scrollIndicator.widthAnchor.constraint(equalToConstant: dynamicWidth)])
//    scrollView
//      .trailingAnchor
//      .constraint(
//        lessThanOrEqualTo: trailingAnchor,
//        constant: -FruitsViewWidth + offset + dynamicWidth)
//      .isActive = true
  }
  
  func updateScrollView(dynamicWidth width: CGFloat) {
    UIView.animate(
      withDuration: 0.3,
      delay: 0,
      options: .curveEaseOut,
      animations: { [weak self] in
        guard let self = self else { return }
        scrollIndicator
          .widthAnchor
          .constraint(equalToConstant: width)
          .isActive = true
      })
  }
  
}

// MARK: - FruitsScrollViewDelegate
extension FruitsScrollView: FruitsScrollViewDelegate {
  
  func didScroll(_ scrollView: UIScrollView) {
    
    /// print("test check")
    let contentOffsetX = scrollView.contentOffset.x
    let scrollTotalX = scrollView.contentSize.width
    let offset = contentOffsetX * FruitsViewWidth / scrollTotalX
    /// 이걸 통해서 스크롤 뷰가 이동하는것 표시함.
    updateScrollView(currentPosition: offset)
    
    /// 이제 남은건 스크롤 뷰의 사이즈임.
    /// updateScrollView(dynamicWidth: 100)
    print(offset)
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
    // 이래하면 leading에 찰싹 달라붙는다.
    // 원래는 392가 뷰 길이인데 스크롤 뷰 길이기 있기 때메 그거 더해야함.
    // -392 + 40
    
    NSLayoutConstraint.activate([
      scrollIndicator.topAnchor.constraint(equalTo: topAnchor),
      scrollIndicator.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
      scrollIndicator.trailingAnchor.constraint(
        lessThanOrEqualTo: trailingAnchor,
        constant: -FruitsViewWidth + FruitsScrollViewWidth ),
      scrollIndicator.bottomAnchor.constraint(equalTo: bottomAnchor),
      scrollIndicator.widthAnchor.constraint(equalToConstant: 40)])
    
  }
  
}
