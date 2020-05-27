//
//  BlankView.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class BlankView: BuildableView {
  let label = UILabel()
  
  override func addViews() {
    addSubview(label)
  }
  
  override func anchorViews() {
    label.fillSuperview()
  }
  
  override func configureViews() {
    backgroundColor = .white
    label.textAlignment = .center
    label.numberOfLines = 0
    label.text = "No Internet Connection"
  }
}
