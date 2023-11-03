//
//  PetViewController.swift
//  DynamicTableViewCellWithAnimation
//
//  Created by 양승현 on 11/4/23.
//

import UIKit

final class PetViewController: UIViewController {
  // MARK: - Properties
  private lazy var tableView: UITableView = {
    $0.separatorInset = .zero
    $0.rowHeight = UITableView.automaticDimension
    $0.estimatedRowHeight = 7 + 7 + 50
    $0.dataSource = self
    $0.delegate = self
    $0.register(PetCell.self, forCellReuseIdentifier: PetCell.id)
    $0.backgroundColor = .white
    return $0
  }(UITableView(frame: .zero, style: .plain))
  
  private var dataSource: [PetInfo]?
  
  // MARK: - Lifecycle
  override func loadView() {
    view = tableView
    setNavigationBarTitle()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchPets()
  }
}

// MARK: - Private Helpers
private extension PetViewController {
  func fetchPets() {
    dataSource = PetInfo.mockData
    tableView.reloadData()
  }
}

// MARK: - UITableViewDataSource
extension PetViewController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return dataSource?.count ?? 0
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: PetCell.id,
      for: indexPath
    ) as? PetCell else {
      return .init(style: .default, reuseIdentifier: PetCell.id)
    }
    cell.configure(with: dataSource?[indexPath.row])
    return cell
  }
}

// MARK: - UITableViewDelegate
extension PetViewController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    guard let cell = tableView.cellForRow(at: indexPath) as? PetCell else { return }
    dataSource?[indexPath.row].isExpended = !cell.isExpended
    tableView.performBatchUpdates {
      cell.isExpended.toggle()
      UIView.animate(
        withDuration: 0.41,
        delay: 0,
        options: [.curveEaseInOut],
        animations: {
          cell.contentView.layoutIfNeeded()
        }, completion: { _ in
          cell.animateUIForExpendedState()
        })
    }
  }
}
