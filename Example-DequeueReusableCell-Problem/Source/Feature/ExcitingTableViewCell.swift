//
//  ExcitingTableViewCell.swift
//  Example-DequeueReusableCell-Problem
//
//  Created by 양승현 on 2023/07/23.
//

import UIKit

// 문제 상황: ExcitingTableViewCell내부에 VM이 있을 때,
// vm은 init시점에 무조건 nil일 것이고, CellForRowAt시점에
// configure(with:) 에 데이터를 주입해 vm이 nil인 경우에만
// vm의 인스턴스를 초기화 하려고 합니다.
final class ExcitingTableViewCell: UITableViewCell {
  static let id = String(describing: ExcitingTableViewCell.self)
  
  var vm: ExcitingTableViewCellVM!
  
  private lazy var stringView = {
    let label = UILabel()
    label.text = "hi"
    label.font = UIFont.systemFont(ofSize: 20)
    label.textAlignment = .left
    label.frame = contentView.bounds
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(stringView)
    print("cell 초기 생성")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    // vm = nil
  }
  
  deinit {
    print("cell해제")
  }
  
  func configure(with data: String) {
    if vm == nil {
      vm = ExcitingTableViewCellVM(data: data)
      stringView.text = vm.data
      //print("초기화 안된 vm이 생성됬어요 with data: \(data) :)")
    }
  }
}
