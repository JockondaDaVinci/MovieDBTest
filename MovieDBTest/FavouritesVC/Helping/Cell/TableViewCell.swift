//
//  TableViewCell.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class TableViewCell: BuildableTableViewCell<TableViewCellView, String> {
  override func config(with object: String) {
    mainView.titleLabel.text = object
  }
}
