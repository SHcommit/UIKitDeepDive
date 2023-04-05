//
//  Utils.swift
//  CustomPagingViewWithCollectionView
//
//  Created by 양승현 on 2023/04/03.
//

import UIKit

protocol ConvenienceInit {}

// extension UIView: ConvenienceInit {}
extension NSObject: ConvenienceInit { }

extension ConvenienceInit where Self: AnyObject {
  @inlinable
  internal func setup(_ apply: (Self) throws -> Void) rethrows -> Self {
    try apply(self)
    return self
  }
}
