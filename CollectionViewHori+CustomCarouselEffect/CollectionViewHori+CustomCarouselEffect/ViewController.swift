//
//  ViewController.swift
//  CollectionViewHori+CustomCarouselEffect
//
//  Created by 양승현 on 2023/03/29.
//

import UIKit

let colors: [UIColor] = [
  .blue,.black,.brown,.cyan,.systemPink,
  .blue,.black,.brown,.cyan,.systemPink,
  .blue,.black,.brown,.cyan,.systemPink,
  .blue,.black,.brown,.cyan,.systemPink,
  .blue,.black,.brown,.cyan,.systemPink]

class ViewController: UIViewController {
  
  //MARK: - Properties
  let CellId = "CollectionViewCell"
  var lastScrollOffset: CGFloat = 0
  let effect = UIBlurEffect(style: .dark)
  var blurView: UIVisualEffectView! {
    didSet {
      view.addSubview(blurView)
      blurView.frame = view.bounds
    }
  }
  let collectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout)
    cv.backgroundColor = .clear
    return cv
  }()

  //MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CellId)
    blurView = UIVisualEffectView(effect: effect)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(collectionView)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.decelerationRate = .fast
    setupConstraints()

  }
}


//MARK: - Collection view data source
extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return colors.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath)
    cell.layer.cornerRadius = 14
    cell.backgroundColor = colors[indexPath.row]
    if indexPath.row != 0 {
      cell.transform = CGAffineTransform(scaleX: 1, y: 0.87)
    }
    if indexPath.row == 0 {
      view.backgroundColor = colors[indexPath.row]
    }
    return cell
  }
  
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = view.frame.width/3
    return CGSize(width: width, height: view.frame.width/2)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 17
  }
  
}

extension ViewController: UIScrollViewDelegate {
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let cellArea = CGFloat(Int(view.frame.width)/3 + 17)
    var offset = targetContentOffset.pointee
    let idx = round(offset.x/cellArea)
    offset = CGPoint(x: idx*cellArea, y: 0)
    targetContentOffset.pointee = offset
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let cellArea = CGFloat(Int(view.frame.width)/3 + 17)
    let curScrollOffset = scrollView.contentOffset.x
    
    if lastScrollOffset < curScrollOffset {
      let idx = collectionView.contentOffset.x / cellArea
      let indexPath = IndexPath(item: Int(round(idx)), section: 0)
      if let cell = collectionView.cellForItem(at: indexPath) {
        transformCellOriginSize(cell) {
          print("오른쪽 갈 때 현재꺼 키움")
          self.view.backgroundColor = colors[indexPath.row]
        }
      }
      let prevIndexPath = IndexPath(
        item: Int(round(idx) - 1), section: 0)
      if let prevCell = collectionView.cellForItem(at: prevIndexPath) {
        transformCellMinifyWithAnimation(prevCell) {
          print("오른쪽 갈 때 현재 이전꺼 축소")
        }
      }
    } else if lastScrollOffset > curScrollOffset {
      let idx = Int(round(lastScrollOffset / cellArea))
      let indexPath = IndexPath(item: idx, section: 0)
      if let cell = collectionView.cellForItem(at: indexPath) {
        transformCellMinifyWithAnimation(cell) {
          print("왼쪽 갈 때 현재꺼 축소")
        }
      }
      let prevIdx = collectionView.contentOffset.x / cellArea
      let prevIndexPath = IndexPath(item: Int(round(prevIdx)), section: 0)
      if let prevCell = collectionView.cellForItem(at: prevIndexPath) {
        transformCellOriginSize(prevCell) {
          print("왼쪽 갈 때 이전 cell 키움")
          self.view.backgroundColor = colors[indexPath.row]
        }
      }
    }
    print("----")
    lastScrollOffset = scrollView.contentOffset.x
  }
}

//MARK: - Helpers
extension ViewController {
  
  func transformCellOriginSize(
    _ cell: UICollectionViewCell,
    completion: @escaping () -> Void) {
    UIView.animate(
      withDuration: 0.13,
      delay: 0,
      options: .curveEaseOut,
      animations: {cell.transform = .identity}) {_ in
        completion()
      }
  }
  
  func transformCellMinifyWithAnimation(
    _ cell: UICollectionViewCell,
    completion: @escaping () -> Void) {
      UIView.animate(
        withDuration: 0.13,
        delay: 0,
        options: .curveEaseOut,
        animations: {cell.transform = CGAffineTransform(scaleX: 1, y: 0.87)}) {_ in
          completion()
        }
    }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(
        equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leftAnchor.constraint(
        equalTo: view.leftAnchor),
      collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: view.frame.width/2)])
    
    NSLayoutConstraint.activate([
      blurView.topAnchor.constraint(equalTo: view.topAnchor),
      blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
      blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
    ])
    
  }
}
