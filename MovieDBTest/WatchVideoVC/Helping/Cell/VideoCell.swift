//
//  VideoCell.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class VideoCell: BuildableCollectionViewCell<VideoCellView, VideoModel> {
  override func config(with object: VideoModel) {
    mainView.videoView.load(withVideoId: object.key)
    mainView.titleLabel.text = object.name
  }
}
