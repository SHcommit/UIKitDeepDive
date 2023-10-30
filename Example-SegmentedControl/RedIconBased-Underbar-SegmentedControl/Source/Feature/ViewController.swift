//
//  ViewController.swift
//  RedIconBased-Underbar-SegmentedControl
//
//  Created by 양승현 on 10/30/23.
//

import UIKit

class ViewController: UIViewController {
  // MARK: - Propertie
  private let segment = RedIconBasedUnderbarSegmentedControl(
    items: ["마시멜로","사과","포도"],
    underbarInfo: .init(height: 3, barColor: .orange, backgroundColor: .lightGray.withAlphaComponent(0.7)))
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    segment.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(segment)
    NSLayoutConstraint.activate([
      segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      segment.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      segment.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      segment.heightAnchor.constraint(equalToConstant: 47)])
    autoSelectEverySecond()
  }
}

// MARK: - Private Helpers
private extension ViewController {
  func autoSelectEverySecond() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
      self.segment.selectedSegmentIndex = 1
    })
    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
      self.segment.selectedSegmentIndex = 2
      /// 이때 다른 '알림' 페이지에서 알림이 온 경우
      self.segment.showSpecificRedIcon(with: 0)
    })
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
      /// 사용자가 알림 눌렀다고 가정
      self.segment.selectedSegmentIndex = 0
    })
  }
}
