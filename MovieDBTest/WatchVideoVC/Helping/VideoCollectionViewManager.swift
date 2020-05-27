//
//  VideoCollectionViewManager.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class VideoCollectionViewManager: NSObject {
  private var data: [VideoModel]

  init(_ collectionView: UICollectionView, data: [VideoModel]) {
    self.data = data
    super.init()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.reloadData()
  }
}

//MARK: - UICollectionViewDataSource
extension VideoCollectionViewManager: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeue(cellOfType: VideoCell.self, for: indexPath) else { return UICollectionViewCell() }
    let item = data[indexPath.item]
    cell.config(with: item)
    return cell
  }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension VideoCollectionViewManager: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
}
