//
//  FavouritesView.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class FavouritesView: BuildableView {
  let tableView = UITableView()
  
  override func addViews() {
    addSubview(tableView)
  }
  
  override func anchorViews() {
    tableView.fillSuperview()
  }
  
  override func configureViews() {
    tableView.backgroundColor = .white
    tableView.register(cell: TableViewCell.self)
  }
}
