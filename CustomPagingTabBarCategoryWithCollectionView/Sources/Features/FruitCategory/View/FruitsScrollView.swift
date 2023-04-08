//
//  FruitsScrollView.swift
//  CustomPagingTabBarCategory
//
//  Created by 양승현 on 2023/04/08.
//

import UIKit

final class FruitsScrollView: UIView {
  
  // MARK: - Constraints
  let FruitsScrollViewHeight = 3.2
  
  // MARK: - Properties
  private let background = UIView().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .lightGray.withAlphaComponent(0.2)
  }
  
  private lazy var scrollView: UIView = UIView().set {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .gray
    $0.layer.cornerRadius = 4
  }
  
  var dynamicWidth: CGFloat? = 40 {
    didSet {
      guard let dynamicWidth = dynamicWidth else { return }
      updateScrollViewLayout(with: dynamicWidth)
    }
  }
  
  private var leadingOffset: NSLayoutXAxisAnchor?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: FruitsScrollViewHeight).isActive = true
    configureSubviews()
  }
  convenience init(scrollViewWidth: CGFloat) {
    self.init(frame: .zero)
    print(scrollViewWidth)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func updateScrollViewLayout(with offset: CGFloat) {
    scrollView.leadingAnchor.constraint(
      lessThanOrEqualTo: leadingAnchor,
      constant: offset)
    .isActive = true
  }
  
}

extension FruitsScrollView: FruitsScrollViewDelegate {
  
  func didScroll(_ scrollView: UIScrollView) {
    let contentOffsetX = scrollView.contentOffset.x
    let viewTotalX = bounds.width
    let scrollTotalX = scrollView.contentSize.width
    let offset = contentOffsetX * viewTotalX / scrollTotalX
    /// 이걸 통해서 스크롤 뷰가 이동하는것 표시함.
    updateScrollViewLayout(with: offset)
    
    /// 이제 남은건 스크롤 뷰의 사이즈임.
  }
  
}

// MARK: - ConfigureSubviewsCase
extension FruitsScrollView: ConfigureSubviewsCase {
  
  func configureSubviews() {
    addSubviews()
    setupSubviewsConstraints()
  }
  
  func addSubviews() {
    _=[background, scrollView].map { addSubview($0) }
    bringSubviewToFront(scrollView)
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
    //원래는 392가 뷰 길이인데 스크롤 뷰 길이기 있기 때메 그거 더해야함.
    // -392 + 40
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
      scrollView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
      scrollView.widthAnchor.constraint(equalToConstant: 40)])
    leadingOffset = scrollView.leadingAnchor
  }
  
}
