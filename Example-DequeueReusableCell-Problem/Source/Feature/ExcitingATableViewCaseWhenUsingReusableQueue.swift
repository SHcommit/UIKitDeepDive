//
//  ExcitingATableViewCaseWhenUsingReusableQueue.swift
//  Example-DequeueReusableCell-Problem
//
//  Created by 양승현 on 2023/07/23.
//

import UIKit

enum ExcitingATableViewCaseWhenUsingReusableQueue {
  typealias NotUsingRDElement = (
    cells: [ExcitingTableViewCell],
    dataList: [String])
  
  case usingReusableDequeue([String])
  case notUsingReusableDequeue(NotUsingRDElement)
  
  private var data: Any {
    switch self {
    case .usingReusableDequeue(let dataList):
      return dataList
    case .notUsingReusableDequeue((let cells, let dataList)):
      return (cells, dataList)
    }
  }
  
  var dataTotalCount: Int {
    if let data = data as? [String] {
      return data.count
    }
    else if let data = data as? NotUsingRDElement {
      return data.dataList.count
    }
    return 0
  }

  func makeCell(
    _ tableView: UITableView,
    for indexPath: IndexPath
  ) -> ExcitingTableViewCell {
    if let data = data as? [String] {
      return makeCellUsingReusableQueue(
        tableView,
        for: indexPath,
        from: data)
    } else if let data = data as? NotUsingRDElement {
      return makeCellWithoutReusableQueue(for: indexPath, data: data)
    }
    return .init(style: .default, reuseIdentifier: "UnexpectedState")
  }
}

// MARK: - Private helper
private extension ExcitingATableViewCaseWhenUsingReusableQueue {
  // 재사용 큐를 사용하지 않고 생성된 cell을 반환하기에 tableView필요가 없습니다.
  func makeCellWithoutReusableQueue(
    for indexPath: IndexPath,
    data: NotUsingRDElement
  ) -> ExcitingTableViewCell {
    let cell = data.cells[indexPath.row]
    cell.configure(with: data.dataList[indexPath.row])
    return cell
  }
  
  // tableView에 register 된 cell 특정 id로 등록된 cell을 재사용 큐로부터 또는 Cell.init()을 통해 Cell객체를 받아올 수 있습니다.
  func makeCellUsingReusableQueue(
    _ tableView: UITableView,
    for indexPath: IndexPath,
    from dataSource: [String]
  ) -> ExcitingTableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: ExcitingTableViewCell.id,
      for: indexPath) as? ExcitingTableViewCell
    else {
      return .init(style: .default, reuseIdentifier: ExcitingTableViewCell.id)
    }
    cell.configure(with: dataSource[indexPath.row])
    return cell
  }
}
