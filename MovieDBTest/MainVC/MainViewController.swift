//
//  MainViewController.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum MainViewEvent {
  case onCollectionViewEvent(CollectionViewManagerEvent)
  case onNavigationEvent
}

class MainViewController: BuildableViewController<MainView> {
  private var collectionViewManager: CollectionViewManager?
  var presenter: MainPresenter?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupInitialState()
  }
}

private extension MainViewController {
  func setupInitialState() {
    presenter = MainPresenter()
    presenter?.onViewLoaded()
    presenter?.eventHandler = { [unowned self] event in
      self.handlePresenterEvent(event)
    }
    
    let favButton = UIButton()
    favButton.setTitle("Fav", for: .normal)
    favButton.setTitleColor(.black, for: .normal)
    favButton.addAction(for: .touchUpInside) { [unowned self] in
      self.presenter?.handleViewEvent(.onNavigationEvent)
    }
    let item = UIBarButtonItem(customView: favButton)
    navigationItem.rightBarButtonItem = item
  }
  
  func handlePresenterEvent(_ event: MainPresenterEvent) {
    switch event {
    case .onNetworkSuccess(let data):
      populateData(data)
    case .onNetworkError(let error):
      debugPrint(error.localizedDescription)
    case .toVideoEvent(let id):
      let vc = WatchVideoViewController()
      let presenter = WatchVideoPresenter()
      presenter.movieID = id
      vc.presenter = presenter
      navigationController?.pushViewController(vc, animated: true)
    case .toFavourites:
      let vc = FavouritesViewController()
      navigationController?.pushViewController(vc, animated: true)
    }
  }
  
  func populateData(_ data: [ListItem]) {
    collectionViewManager = CollectionViewManager(mainView.collectionView, data: data)
    setupActions()
  }
  
  func setupActions() {
    collectionViewManager?.eventHandler = { [unowned self] event in
      self.presenter?.handleViewEvent(.onCollectionViewEvent(event))
    }
  }
}
