//
//  CustomScrollableTabBar.swift
//  CustomPagingViewWithCollectionView
//
//  Created by 양승현 on 2023/04/03.
//

import UIKit

class CustomTabBarScrollableView: UIView {
  // MARK: - Constraints
  let tabBarCellID = "CustomTabBarScrollableViewID"
  // MARK: - Properties
  let colors = {
    let colors: [UIColor] = [
      .systemPink, .systemBlue, .systemRed, .systemBlue,
      .systemGray, .systemMint, .systemTeal, .systemBrown,
      .systemOrange, .systemFill, .systemMint, .systemBrown,
      .systemPink, .systemBlue, .systemRed, .systemBlue,
      .systemGray, .systemMint, .systemTeal, .systemBrown,
      .systemOrange, .systemFill, .systemMint, .systemBrown
    ]
    return colors
      .map { $0.withAlphaComponent(0.7) }
}()
  let fruits = [
    "Banana", "Apple", "Grapes", "orange",
    "Melon", "Lime", "Cherry", "Avocado", "Peach",
    "carrot", "pie", "kiwi",
    "Banana", "Apple", "Grapes", "orange",
    "Melon", "Lime", "Cherry", "Avocado", "Peach",
    "carrot", "pie", "kiwi"]
  lazy var collectionView = {
    let layout = UICollectionViewFlowLayout().setup {
      $0.scrollDirection = .horizontal
    }
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
      .setup {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.showsHorizontalScrollIndicator = false
        // $0.isPagingEnabled = true
        $0.decelerationRate = .fast
      }
  }()
  // MARK: - Initialization
  required init?(coder: NSCoder) {
    fatalError("구현x")
  }
  override init(frame: CGRect) {
    super.init(frame: .zero)
    self.setupUI()
    configureSubviews()
  }
}

// MARK: - Helpers
extension CustomTabBarScrollableView {
  func setupUI() {
    translatesAutoresizingMaskIntoConstraints = false
    collectionView.register(
      CustomTabBarCell.self,
      forCellWithReuseIdentifier: tabBarCellID)
    collectionView.backgroundColor = .clear
  }
}

// MARK: - UICollectionViewDataSource
extension CustomTabBarScrollableView: UICollectionViewDataSource {
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
      withReuseIdentifier: tabBarCellID,
      for: indexPath) as? CustomTabBarCell ?? CustomTabBarCell()
    let index = indexPath.row
    cell.setupUI(fruits[index], colors[index])
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CustomTabBarScrollableView: UICollectionViewDelegateFlowLayout {

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let textSize = UILabel().setup {
      $0.text = fruits[indexPath.row]
      $0.font = .systemFont(ofSize: 14)
      $0.sizeToFit()
    }.frame
    let (textWidth, textHeight) = (textSize.width, textSize.height)
    return CGSize(
      width: textWidth + 7 < 50 + 14 ? 50 + 7 : textWidth + 7,
      height: 50+7+textHeight+7)
  }
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 0
  }
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 0
  }
}

extension CustomTabBarScrollableView: UIScrollViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
    let width = layout.itemSize.width
    let page = Int(collectionView.contentOffset.x/width)
    let indexPath = IndexPath(item: page, section: 0)
    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    print(page)
  }
}

// MARK: - ConfigureSubviewsCase
extension CustomTabBarScrollableView: ConfigureSubviewsCase {
  func configureSubviews() {
    addSubviews()
    setupSubviewsConstraints()
  }
  func addSubviews() {
    addSubview(collectionView)
  }
}

// MARK: - SetupSubviewsConstraints
extension CustomTabBarScrollableView: SetupSubviewsConstraints {
  func setupSubviewsConstraints() {
    setupCollectionViewConstraints()
  }
  func setupCollectionViewConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
  }
}
