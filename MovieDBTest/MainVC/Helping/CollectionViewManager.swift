//
//  CollectionViewManager.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum CollectionViewManagerEvent {
  case onFavouriteAction(ListItem)
  case onCellAction(Int)
  case onPaginationInitialazied
}

class CollectionViewManager: NSObject {
  private var data: [ListItem]
  
  var eventHandler: EventHandler<CollectionViewManagerEvent>?
  
  init(_ collectionView: UICollectionView, data: [ListItem]) {
    self.data = data
    super.init()
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.reloadData()
  }
}

//MARK: - UICollectionViewDataSource
extension CollectionViewManager: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeue(cellOfType: CollectionViewCell.self, for: indexPath) else { return UICollectionViewCell() }
    let item = data[indexPath.item]
    cell.config(with: item)
    cell.eventHandler = { [unowned self] action in
      self.eventHandler?(.onFavouriteAction(item))
    }
    return cell
  }
}

//MARK: - UICollectionViewDelegate
extension CollectionViewManager: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = data[indexPath.item]
    eventHandler?(.onCellAction(item.id))
  }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CollectionViewManager: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
    let width = collectionView.bounds.width / 2 - flowLayout.minimumInteritemSpacing
    let height = width + 70.0
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 5.0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 5.0
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard indexPath.item == data.count - 1 else { return }
    eventHandler?(.onPaginationInitialazied)
  }
}
