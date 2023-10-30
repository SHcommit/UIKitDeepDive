//
//  ViewController.swift
//  Default-SegmentedControl
//
//  Created by 양승현 on 10/30/23.
//

import UIKit

class ViewController: UIViewController {
  // MARK: - Properties
  private let segment = UISegmentedControl(items: ["Cherry Page", "Orange Page"])
  
  private let cherryView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .systemPink.withAlphaComponent(0.7)
    $0.layer.cornerRadius = 7
    return $0
  }(UIView())
  
  private let orangeView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.backgroundColor = .orange
    $0.layer.cornerRadius = 7
    return $0
  }(UIView())
  
  private var isAnimationWorking = false
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    orangeView.transform = .init(translationX: view.bounds.width, y: 0)
  }
}

// MARK: - Private Helpers
private extension ViewController {
  func configureUI() {
    setSegment()
    setUI()
    setConstriants()
    view.backgroundColor = .white
  }
  
  func setSegment() {
    segment.translatesAutoresizingMaskIntoConstraints = false
    let image = UIImage()
    let cherry = UIImage(named: "cherry")!
    let orange = UIImage(named: "orange")!
    segment.setImage(cherry.addText( "Cherry page", isImageBeforeText: true), forSegmentAt: 0)
    segment.setImage(orange.addText("Orange page", isImageBeforeText: true), forSegmentAt: 1)
    segment.selectedSegmentIndex = 0
    segment.addTarget(self, action: #selector(didTapSegment), for: .valueChanged)
  }
  
  func updateVisibleView(from: UIView, to: UIView, moveX: CGFloat) {
    to.isHidden = false
    segment.isUserInteractionEnabled = false
    UIView.animate(
      withDuration: 0.38,
      delay: 0,
      options: .curveEaseOut,
      animations: {
        to.transform = .identity
        from.transform = .init(translationX: moveX, y: 0)
      }, completion: { _ in
        from.isHidden = true
        self.segment.isUserInteractionEnabled = true
        self.isAnimationWorking.toggle()
      })
  }
}

// MARK: - Actions
private extension ViewController {
  @objc func didTapSegment(_ sender: UISegmentedControl) {
    guard !isAnimationWorking else { return }
    isAnimationWorking.toggle()
    let width = view.bounds.width
    guard segment.selectedSegmentIndex == 1 else {
      updateVisibleView(from: orangeView, to: cherryView, moveX: width)
      return
    }
    updateVisibleView(from: cherryView, to: orangeView, moveX: -width)
  }
}

// MARK: - Layout
extension ViewController {
  func setUI() {
    [segment, 
     cherryView,
     orangeView
    ].forEach {
      view.addSubview($0)
    }
  }
  
  func setConstriants() {
    let segmentConstraints = [
      segment.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      segment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      segment.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      segment.heightAnchor.constraint(equalToConstant: 70)]
    
    let pagesConstraints: [NSLayoutConstraint] = [
      cherryView,
      orangeView
    ].map {
      return [
        $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
        $0.topAnchor.constraint(equalTo: segment.bottomAnchor, constant: 7),
        $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7),
        $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -7)]
    }.flatMap { $0 }
    
    NSLayoutConstraint.activate(segmentConstraints+pagesConstraints)
  }
}
