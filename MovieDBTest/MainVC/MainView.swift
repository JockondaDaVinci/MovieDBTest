//
//  MainView.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class MainView: BuildableView {
  var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  override func addViews() {
    addSubview(collectionView)
  }
  
  override func anchorViews() {
    collectionView.fillSuperview()
  }
  
  override func configureViews() {
    collectionView.backgroundColor = .white
    collectionView.register(cell: CollectionViewCell.self)
    collectionView.isPrefetchingEnabled = true
  }
}
