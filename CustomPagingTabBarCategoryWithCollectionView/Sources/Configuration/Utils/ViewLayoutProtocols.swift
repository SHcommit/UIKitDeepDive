//
//  ViewLayoutProtocols.swift
//  CustomPagingViewWithCollectionView
//
//  Created by 양승현 on 2023/04/05.
//

/// UIView type's default configure
protocol ConfigureSubviewsCase {
  /// Combine setupview's all configuration
  func configureSubviews()
  /// Add view to view's subview
  func addSubviews()
}

protocol SetupSubviewsConstraints {
  func setupSubviewsConstraints()
}
