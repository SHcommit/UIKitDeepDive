//
//  RedIconBasedUnderbarSegmentedControl.swift
//  RedIconBased-Underbar-SegmentedControl
//
//  Created by 양승현 on 10/30/23.
//

import UIKit

struct UnderbarInfo {
  var height: CGFloat
  var barColor: UIColor
  var backgroundColor: UIColor
}

final class RedIconBasedUnderbarSegmentedControl: UISegmentedControl {
  // MARK: - Constant
  private let redIconWidth: CGFloat = 5
  
  // MARK: - Properties
  private lazy var underbar: UIView = makeUnderbar()
  
  private lazy var underbarWidth: CGFloat? = bounds.size.width / CGFloat(numberOfSegments)
  
  private lazy var redIcons: [UIView] = {
    return (0..<numberOfSegments).map { _ in
      return {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = redIconWidth/2
        $0.layer.backgroundColor = UIColor.red.cgColor
        $0.alpha = 1
        return $0
      }(UIView(frame: .zero))
    }
  }()

  override var selectedSegmentIndex: Int {
    didSet {
      hideSpecificRedIcon(with: selectedSegmentIndex)
      // TODO: - 헨들러를 통해 알림 확인했다는 로직 외부에서 구현!!
    }
  }
  
  private var underbarInfo: UnderbarInfo
  
  private var isFirstSettingDone = false
  
  // MARK: - Lifecycle
  init(frame: CGRect, underbarInfo info: UnderbarInfo) {
    self.underbarInfo = info
    super.init(frame: frame)
    configureUI()
  }
  
  init(items: [Any]?, underbarInfo info: UnderbarInfo) {
    self.underbarInfo = info
    super.init(items: items)
    configureUI()
    selectedSegmentIndex = 0
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    if !isFirstSettingDone {
      isFirstSettingDone.toggle()
      setRedIconInSegmentedViews()
      setUnderbarMovableBackgroundLayer()
      layer.cornerRadius = 0
      layer.masksToBounds = false
    }
    let underBarLeadingSpacing = CGFloat(selectedSegmentIndex) * (underbarWidth ?? 50)
    UIView.animate(withDuration: 0.27, delay: 0, options: .curveEaseOut, animations: {
      self.underbar.transform = .init(translationX: underBarLeadingSpacing, y: 0)
    })
  }
}

// MARK: - Helpers
extension RedIconBasedUnderbarSegmentedControl {
  func showSpecificRedIcon(with index: Int) {
    UIView.animate(withDuration: 0.24, animations: {
      self.redIcons[index].alpha = 1
    })
  }
  
  func hideSpecificRedIcon(with index: Int) {
    UIView.animate(withDuration: 0.24, animations: {
      self.redIcons[index].alpha = 0
    })
  }
}

// MARK: - Private Helpers
private extension RedIconBasedUnderbarSegmentedControl {
  func configureUI() {
    removeBorders()
    setTitleTextAttributes([
      .foregroundColor: UIColor.black,
      .font: UIFont.systemFont(ofSize: 16)], for: .normal)
    setTitleTextAttributes([
      .foregroundColor: underbarInfo.barColor,
      .font: UIFont.systemFont(ofSize: 16)], for: .selected)
    if #available(iOS 13.0, *) {
      selectedSegmentTintColor = .clear
    } else {
      tintColor = .clear
    }
  }
  
  func setUnderbarMovableBackgroundLayer() {
    let backgroundLayer = CALayer()
    backgroundLayer.frame = .init(
      x: 0,
      y: bounds.height - underbarInfo.height,
      width: bounds.width,
      height: underbarInfo.height)
    backgroundLayer.backgroundColor = underbarInfo.backgroundColor.cgColor
    layer.addSublayer(backgroundLayer)
  }
  
  func setRedIconInSegmentedViews() {
    let titles = (0..<numberOfSegments).map {
      titleForSegment(at: $0)
    }
    let segmentedTitleLabels = subviews
      .compactMap { subview in
        subview.subviews.compactMap { $0 as? UILabel }
      }
      .flatMap { $0 }
      .sorted {
        guard
          let idx1 = titles.firstIndex(of: $0.text ?? ""),
          let idx2 = titles.firstIndex(of: $1.text ?? "")
        else { return false }
        return idx1 < idx2
      }
    
    segmentedTitleLabels.enumerated().forEach {
      let redIcon = redIcons[$0]
      $1.addSubview(redIcon)
      NSLayoutConstraint.activate([
        redIcon.widthAnchor.constraint(equalToConstant: redIconWidth),
        redIcon.heightAnchor.constraint(equalToConstant: redIconWidth),
        redIcon.topAnchor.constraint(equalTo: $1.topAnchor),
        redIcon.trailingAnchor.constraint(equalTo: $1.trailingAnchor, constant: redIconWidth*2)])
      
    }
  }
  
  func makeUnderbar() -> UIView {
    return {
      $0.translatesAutoresizingMaskIntoConstraints = false
      $0.backgroundColor = underbarInfo.barColor
      addSubview($0)
      NSLayoutConstraint.activate([
        $0.leadingAnchor.constraint(equalTo: leadingAnchor),
        $0.bottomAnchor.constraint(equalTo: bottomAnchor),
        $0.widthAnchor.constraint(equalToConstant: underbarWidth ?? 50),
        $0.heightAnchor.constraint(equalToConstant: underbarInfo.height)])
      return $0
    }(UIView(frame: .zero))
  }
  
  func removeBorders() {
    let image = UIImage()
    setBackgroundImage(image, for: .normal, barMetrics: .default)
    setBackgroundImage(image, for: .selected, barMetrics: .default)
    setBackgroundImage(image, for: .highlighted, barMetrics: .default)
    setDividerImage(image, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
  }
}
