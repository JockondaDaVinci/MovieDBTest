//
//  TableViewCellView.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class TableViewCellView: BuildableView {
  let titleLabel = UILabel()
  
  override func addViews() {
    addSubview(titleLabel)
  }
  
  override func anchorViews() {
    titleLabel.fillSuperview()
  }
  
  override func configureViews() {
    backgroundColor = .white
    titleLabel.numberOfLines = 0
  }
}
