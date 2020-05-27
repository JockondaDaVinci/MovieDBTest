//
//  WatchVideoPresenter.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

enum WatchVideoPresenterEvent {
  case onNetworkSuccess(ListItem)
  case onNetworkError(Error)
}

class WatchVideoPresenter {
  private let networkingManager = NetworkingManager.shared
  var movieID = 0
  var eventHandler: EventHandler<WatchVideoPresenterEvent>?
  
  func onViewLoaded() {
    loadData(forID: movieID)
  }
}

private extension WatchVideoPresenter {
  func loadData(forID id: Int) {
    networkingManager.startGetTask(forURL: API.Movie.details(forID: id), object: ListItem.self) { [unowned self] data, error in
      if let error = error {
        self.eventHandler?(.onNetworkError(error))
      }
      
      guard let data = data else { return }
      self.eventHandler?(.onNetworkSuccess(data))
    }
  }
}
