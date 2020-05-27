//
//  ViewBuildable.swift
//  FannexSDK
//
//  Created by Maksym Balukhtin on 7/16/19.
//  Copyright © 2019 Maksym Balukhtin. All rights reserved.
//

import UIKit

class BuildableView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    addViews()
    configureViews()
    anchorViews()
  }
  
  @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError("not implemented")
  }
  
  func addViews() { }
  
  func configureViews() { }
  
  func anchorViews() { }
}
