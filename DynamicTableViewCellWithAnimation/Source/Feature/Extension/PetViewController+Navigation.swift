//
//  PetViewController+.swift
//  DynamicTableViewCellWithAnimation
//
//  Created by 양승현 on 11/4/23.
//

import UIKit

extension PetViewController {
  func setNavigationBarTitle() {
    guard let naviBar = navigationController?.navigationBar else {
      return
    }
    naviBar.topItem?.title = "Dynamic Pet List: ]"
    naviBar.titleTextAttributes = [.foregroundColor: UIColor.systemPink]
  }
}
