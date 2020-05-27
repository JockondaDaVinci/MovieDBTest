//
//  TableViewManager.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum TableViewManagerEvent {
  case onTableViewDeleteAction(Int)
}

class TableViewManager: NSObject {
  private var data: [DBManagedModel]
  
  var eventHandler: EventHandler<TableViewManagerEvent>?
  
  init(_ tableView: UITableView, data: [DBManagedModel]) {
    self.data = data
    super.init()
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.reloadData()
  }
}

extension TableViewManager: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeue(cellOfType: TableViewCell.self, for: indexPath) else { return UITableViewCell() }
    let item = data[indexPath.row]
    cell.config(with: item.title)
    return cell
  }
}

extension TableViewManager: UITableViewDelegate {
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == .delete else { return }
    tableView.beginUpdates()
    tableView.deleteRows(at: [indexPath], with: .automatic)
    let item = data[indexPath.row]
    eventHandler?(.onTableViewDeleteAction(item.id))
    data.remove(at: indexPath.row)
    tableView.endUpdates()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44.0
  }
}
