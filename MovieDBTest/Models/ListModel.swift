//
//  ListModel.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

struct ListModel: Codable {
  let page, totalPages: Int
  let results: [ListItem]
  
  enum CodingKeys: String, CodingKey {
    case page, results
    case totalPages = "total_pages"
  }
}

// MARK: - ListItem
struct ListItem: Codable {
  let id: Int
  let title: String?
  let overview, posterPath, releaseDate: String
  let videos: VideoListModel?
  
  enum CodingKeys: String, CodingKey {
    case id, title, overview, videos
    case releaseDate = "release_date"
    case posterPath = "poster_path"
  }
}
