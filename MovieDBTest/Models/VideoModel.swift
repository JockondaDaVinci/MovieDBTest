//
//  VideoModel.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import Foundation

struct VideoListModel: Codable {
  let results: [VideoModel]
}

struct VideoModel: Codable {
  let key, name: String
}
