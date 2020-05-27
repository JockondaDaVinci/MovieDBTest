//
//  CollectionViewCell.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

enum CollectionViewCellEvent {
  case onFavouriteAction
}

class CollectionViewCell: BuildableCollectionViewCell<CollectionViewCellView, ListItem> {
  var eventHandler: EventHandler<CollectionViewCellEvent>?
  override func config(with object: ListItem) {
    mainView.imageView.downloaded(fromURL: object.posterPath)
    mainView.titleLabel.text = object.title
    setupAction()
  }
}

private extension CollectionViewCell {
  func setupAction() {
    mainView.favouriteButton.addAction(for: .touchUpInside) { [weak self] in
      guard let self = self else { return }
      self.eventHandler?(.onFavouriteAction)
    }
  }
}
