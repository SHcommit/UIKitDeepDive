//
//  PetCellDelegate.swift
//  DynamicTableViewCellWithAnimation
//
//  Created by 양승현 on 11/4/23.
//

import UIKit

protocol PetCellDelegate: AnyObject {
  func petCell(_ tableViewCell: UITableViewCell, expanded: Bool)
}
