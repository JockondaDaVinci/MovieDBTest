//
//  WatchVideoViewController.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class WatchVideoViewController: BuildableViewController<WatchVideoView> {
  private var collectionViewManager: VideoCollectionViewManager?
  var presenter: WatchVideoPresenter?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupInitialState()
  }
}

private extension WatchVideoViewController {
  func setupInitialState() {
    presenter?.onViewLoaded()
    presenter?.eventHandler = { [unowned self] event in
      self.handlePresenterEvent(event)
    }
  }
  
  func handlePresenterEvent(_ event: WatchVideoPresenterEvent) {
    switch event {
    case .onNetworkSuccess(let data):
      populateData(data)
    case .onNetworkError(let error):
      debugPrint(error.localizedDescription)
    }
  }
  
  func populateData(_ data: ListItem) {
    mainView.titleLabel.text = data.title
    mainView.yearLabel.text = data.releaseDate
    mainView.descTextView.text = data.overview
    guard let videos = data.videos?.results else { return }
    collectionViewManager = VideoCollectionViewManager(mainView.videoCollectionView, data: videos)
  }
}
