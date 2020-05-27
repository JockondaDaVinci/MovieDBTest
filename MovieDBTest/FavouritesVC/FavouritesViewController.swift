//
//  FavouritesViewController.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

enum FavouritesViewEvent {
  case onTableViewEvent(TableViewManagerEvent)
}

class FavouritesViewController: BuildableViewController<FavouritesView> {
  private var tableViewManager: TableViewManager?
  var presenter: FavouritesPresenter?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupInitialState()
  }
}

private extension FavouritesViewController {
  func setupInitialState() {
    presenter = FavouritesPresenter()
    presenter?.eventHandler = { [unowned self] event in
      self.handlePresenterEvent(event)
    }
    presenter?.onViewLoaded()
  }
  
  func handlePresenterEvent(_ event: FavouritesPresenterEvent) {
    switch event {
    case .onNetworkSuccess(let data):
      populateData(data)
    case .onNetworkError(let error):
      debugPrint(error)
    }
  }
  
  func populateData(_ data: [DBManagedModel]) {
    tableViewManager = TableViewManager(mainView.tableView, data: data)
    tableViewManager?.eventHandler = { [unowned self] event in
      self.presenter?.handleViewEvent(.onTableViewEvent(event))
    }
  }
}
