//
//  ViewController.swift
//  RedIconBased-Underbar-SegmentedControl
//
//  Created by 양승현 on 10/30/23.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - Properties
  private let colors: [UIColor] = [.yellow, .green.withAlphaComponent(0.6), .blue.withAlphaComponent(0.6)]
  
  private let segment = RedIconBasedUnderbarSegmentedControl(items: ["마시멜로","사과","포도"], underbarInfo: .init(height: 3, barColor: .orange, backgroundColor: .lightGray.withAlphaComponent(0.7)))
  
  private lazy var detailsPages: [UIView] = (0..<3).map { index in
    return {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.backgroundColor = colors[index]
      $0.layer.cornerRadius = 14
      if index > 0 { $0.isHidden = true }
      return $0
    }(UIView(frame: .zero))
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
}

// MARK: - Private Helpers
private extension ViewController {
  func configureUI() {
    view.backgroundColor = .white
    segment.translatesAutoresizingMaskIntoConstraints = false
    segment.selectedSegmentIndex = 0
    setUI()
    setConstraints()
    autoSelectEverySecond()
  }
  
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
  
// MARK: - Layout
private extension ViewController {
  func setUI() {
    _=[
      segment,
      detailsPages[0],
      detailsPages[1],
      detailsPages[2]
    ].map {
      view.addSubview($0)
    }
  }
  
  func setConstraints() {
    let segmentConstraints = [
      segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      segment.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      segment.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      segment.heightAnchor.constraint(equalToConstant: 47)]
    
    let detailsPagesConstraints: [NSLayoutConstraint] = detailsPages
      .map {
        return [
          $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
          $0.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 14),
          $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
          $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -14)]
      }.flatMap { $0 }
    NSLayoutConstraint.activate(segmentConstraints+detailsPagesConstraints)
  }
}
