//
//  ExcitingTableView.swift
//  Example-DequeueReusableCell-Problem
//
//  Created by 양승현 on 2023/07/23.
//

import UIKit

final class ExcitingTableView: UITableView {
  // MARK: - Properties
  private var tableViewType: ExcitingATableViewCaseWhenUsingReusableQueue
  
  // MARK: - Lifecycle
  private override init(frame: CGRect, style: UITableView.Style) {
    // Not Using
    tableViewType = .notUsingReusableDequeue(([],[]))
    super.init(frame: frame, style: style)
  }
  
  init(
    frame: CGRect,
    style: UITableView.Style,
    reusalbeQueueType tableViewType: ExcitingATableViewCaseWhenUsingReusableQueue
  ) {
    self.tableViewType = tableViewType
    super.init(frame: frame, style: style)
    register(ExcitingTableViewCell.self, forCellReuseIdentifier: ExcitingTableViewCell.id)
    dataSource = self
  }
  
  convenience init(
    reusableQueueType tableViewType: ExcitingATableViewCaseWhenUsingReusableQueue
  ) {
    self.init(
      frame: .zero,
      style: .plain,
      reusalbeQueueType: tableViewType)
  }
  
  required init?(coder: NSCoder) {
    tableViewType = .usingReusableDequeue([])
    super.init(coder: coder)
  }
}

// MARK: - UITableViewDataSource
extension ExcitingTableView: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return tableViewType.dataTotalCount
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    return tableViewType.makeCell(tableView, for: indexPath)
  }
}
