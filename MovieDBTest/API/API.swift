//
//  API.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

fileprivate let apiBase = "https://api.themoviedb.org/3"

enum API {
  static let authKey = "api_key=cab07435e333406721fb0192ef93a0be"
  static let imageBase = "https://image.tmdb.org/t/p/w500"
  
  enum Movie {
    static func popular(withPage page: Int) -> String {
      return [apiBase, "/movie/popular/", "?page=\(page)&"].joined()
    }
    
    static func details(forID id: Int) -> String {
      return [apiBase, "/movie/", "\(id)", "?append_to_response=videos&"].joined()
    }
  }
}
