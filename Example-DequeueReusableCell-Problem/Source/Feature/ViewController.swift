//
//  ViewController.swift
//  Example-DequeueReusableCell-Problem
//
//  Created by 양승현 on 2023/07/23.
//

import UIKit

class ViewController: UIViewController {
  // MARK: - Properties
  /// dequeueReusableCell을 사용하지 않으면 결국 모든 인스턴스를 메모리에 할당 후 유지해야 합니다.
  /// 자동으로 기존에 만들어진 Cell을 재사용하지 않기 때문입니다.
  lazy var cells: [ExcitingTableViewCell] = (0...9999)
    .map { _ in return
      ExcitingTableViewCell(style: .default, reuseIdentifier: ExcitingTableViewCell.id)
    }
  
  /// 재사용 큐에서 꺼내진 Cell의 데이터를 채울 때 사용됩니다.
  lazy var dataSource: [String] = (0...9999)
    .map { return "\($0)번 데이터사용!!" }
                                                              
  var tableView: ExcitingTableView!

  // MARK: - Lifecycle
  override func loadView() {
    view = tableView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView = makeTableView(with: .WithUsingReusableQueue)
  }
  
  // Usage: with using or notUsing.. 전자의 경우 재사용 큐 사용, 후자의 경우 재사용 큐 사용x
  private func makeTableView(with: TableViewMakeCase) -> ExcitingTableView {
    switch with {
    // MARK: - With using reusable queue
    // reusableQueueType을 .usingReusableQueue 할 땐
    // 재사용 큐를 사용한 Cell 초기화 == 이 때의 경우 문제 발생
    case .WithUsingReusableQueue:
      return usingReusableQueue
      
    // MARK: - Without using reusable queue
    // .notUsingReusableQueue를 사용할 경우 재사용 큐 없이 초기화
    case .WithoutUsingReusableQueue:
      return notUsingReusableQueue
    }
  }
}

// MARK: - Private helper
private extension ViewController {
  enum TableViewMakeCase {
    case WithUsingReusableQueue
    case WithoutUsingReusableQueue
  }
  
  var notUsingReusableQueue: ExcitingTableView {
    return .init(
      reusableQueueType: .notUsingReusableDequeue((cells, dataSource)))
  }
  
  var usingReusableQueue: ExcitingTableView {
    return .init(reusableQueueType: .usingReusableDequeue(dataSource))
  }
}
