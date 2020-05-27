//
//  FavouritesPresenter.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

enum FavouritesPresenterEvent {
  case onNetworkSuccess([DBManagedModel])
  case onNetworkError(Error)
}

class FavouritesPresenter {
  private let coreDataManager = CoreDataManager.shared
  var eventHandler: EventHandler<FavouritesPresenterEvent>?
  
  func onViewLoaded() {
    loadData()
  }
  
  func handleViewEvent(_ event: FavouritesViewEvent) {
    switch event {
    case .onTableViewEvent(let tableViewEvent):
      switch tableViewEvent {
      case .onTableViewDeleteAction(let itemID):
        coreDataManager.delete(byID: itemID)
      }
    }
  }
}

private extension FavouritesPresenter {
  func loadData() {
    coreDataManager.retrieve { data, error in
      if let error = error {
        eventHandler?(.onNetworkError(error))
        return
      }
      
      guard let data = data else { return }
      eventHandler?(.onNetworkSuccess(data))
    }
  }
}
