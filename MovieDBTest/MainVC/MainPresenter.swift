//
//  MainPresenter.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

enum MainPresenterEvent {
  case onNetworkSuccess([ListItem])
  case onNetworkError(Error)
  case toVideoEvent(Int)
  case toFavourites
}

class MainPresenter {
  private let networkingManager = NetworkingManager.shared
  private let coreDataManager = CoreDataManager.shared
  private var currentPage = 1
  private var maxPage = 1
  private var items = [ListItem]()
  var eventHandler: EventHandler<MainPresenterEvent>?
  
  func onViewLoaded() {
    loadData(currentPage)
  }
  
  func handleViewEvent(_ event: MainViewEvent) {
    switch event {
    case .onCollectionViewEvent(let collectionViewEvent):
      switch collectionViewEvent {
      case .onFavouriteAction(let item):
        coreDataManager.store(item)
      case .onCellAction(let id):
        eventHandler?(.toVideoEvent(id))
      case .onPaginationInitialazied:
        guard currentPage < maxPage else { return }
        currentPage += 1
        loadData(currentPage)
      }
    case .onNavigationEvent:
      eventHandler?(.toFavourites)
    }
  }
}

private extension MainPresenter {
  func loadData(_ page: Int) {
    networkingManager.startGetTask(forURL: API.Movie.popular(withPage: page), object: ListModel.self) { [unowned self] data, error in
      if let error = error {
        self.eventHandler?(.onNetworkError(error))
        return
      }
      
      guard let data = data else { return }
      self.items.append(contentsOf: data.results)
      self.eventHandler?(.onNetworkSuccess(self.items))
      self.maxPage = data.totalPages
    }
  }
  
  
}
