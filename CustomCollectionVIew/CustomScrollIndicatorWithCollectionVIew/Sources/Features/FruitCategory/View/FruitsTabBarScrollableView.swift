//
//  CustomScrollableTabBar.swift
//  CustomPagingViewWithCollectionView
//
//  Created by 양승현 on 2023/04/03.
//

import UIKit

protocol FruitsScrollViewDelegate: AnyObject {
  
  func didScroll(_ scrollView: UIScrollView)
  
}

class FruitsTabBarScrollableView: UIView {
  
  // MARK: - Constraints
  let TabBarCellID = "CustomTabBarScrollableViewID"
  let FruitsCellHeight: CGFloat = 50+7+17+7
  let FruitsCellSpacing: Int = 14
  var FruitsTabBarWidth: CGFloat = 0
  
  // MARK: - Properties
  
  let colors = {
    let colors: [UIColor] = [
      .systemPink, .systemBlue, .systemRed, .systemBlue,
      .systemGray, .systemTeal, .systemTeal, .systemBrown,
      .systemOrange, .systemFill, .systemTeal, .systemBrown,
      .systemPink, .systemBlue, .systemRed, .systemBlue,
      .systemGray, .systemTeal, .systemTeal, .systemBrown,
      .systemOrange, .systemFill, .systemTeal, .systemBrown
    ]
    return colors
      .map { $0.withAlphaComponent(0.7) }
  }()
  
  let fruits = {
    ["Banana", "Apple", "Grapes", "orange",
     "Melon", "Lime", "Cherry", "Avocado",
     "Peach", "carrot", "pie", "kiwi",
     "Banana", "Apple", "Grapes", "orange",
     "Melon", "Lime", "Cherry", "Avocado",
     "Peach", "carrot", "pie", "kiwi"]
  }()
  
  var delegate: FruitsScrollViewDelegate?
  
  lazy var collectionView = {
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().set {
      $0.scrollDirection = .horizontal
    }

    return UICollectionView(frame: .zero, collectionViewLayout: layout)
      .set {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.showsHorizontalScrollIndicator = false
        $0.decelerationRate = .fast
      }
  }()
  
  lazy var scrollIndicator = FruitsScrollView(
    viewWidth: FruitsTabBarWidth
  ).set {
    self.delegate = $0
  }
  
  // MARK: - Initialization
  required init?(coder: NSCoder) {
    fatalError("구현x")
  }
  
  private override init(frame: CGRect) {
    super.init(frame: .zero)
    self.setupUI()
  }
  
  convenience init(fruitsTabBarWidth: CGFloat) {
    self.init(frame: .zero)
    self.FruitsTabBarWidth = fruitsTabBarWidth
    configureSubviews()
  }
  
}

// MARK: - Helpers
extension FruitsTabBarScrollableView {
  
  func setupUI() {
    translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(
      FruitsTabBarCell.self,
      forCellWithReuseIdentifier: TabBarCellID)
    collectionView.backgroundColor = .clear
  }
  
}

// MARK: - UICollectionViewDataSource
extension FruitsTabBarScrollableView: UICollectionViewDataSource {
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return fruits.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: TabBarCellID,
      for: indexPath) as? FruitsTabBarCell ?? FruitsTabBarCell()
    let index = indexPath.row
    cell.setupUI(fruits[index], colors[index])
    return cell
  }
  
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FruitsTabBarScrollableView: UICollectionViewDelegateFlowLayout {

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let textSize = UILabel().set {
      $0.text = fruits[indexPath.row]
      $0.font = .systemFont(ofSize: 14)
      $0.sizeToFit()
    }.frame
    
    let textWidth = (Int(textSize.width))
    return CGSize(
      width: textWidth < 50 ? 50 : textWidth,
      height: Int(FruitsCellHeight))
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return CGFloat(FruitsCellSpacing)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 0
  }
  
}

// MARK: - UISCrollViewDeleagte
extension FruitsTabBarScrollableView: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if collectionView == scrollView {
      delegate?.didScroll(scrollView)
      guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
      let width = layout.itemSize.width
      let page = Int(collectionView.contentOffset.x/width)
      _ = IndexPath(item: page, section: 0)
    }
  }
  
}

// MARK: - ConfigureSubviewsCase
extension FruitsTabBarScrollableView: ConfigureSubviewsCase {
  
  func configureSubviews() {
    addSubviews()
    setupSubviewsConstraints()
  }
  
  func addSubviews() {
    _=[scrollIndicator, collectionView].map { addSubview($0) }
  }
  
}

// MARK: - SetupSubviewsConstraints
extension FruitsTabBarScrollableView: SetupSubviewsConstraints {
  
  func setupSubviewsConstraints() {
    setupCollectionViewConstraints()
  }
  
  func setupCollectionViewConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.heightAnchor.constraint(
        equalToConstant: FruitsCellHeight)])
    NSLayoutConstraint.activate([
      scrollIndicator.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 4),
      scrollIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollIndicator.bottomAnchor.constraint(equalTo: bottomAnchor)])
  }
}
