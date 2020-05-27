//
//  VideoCellView.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class VideoCellView: BuildableView {
  let videoView = WKYTPlayerView()
  let titleLabel = UILabel()
  
  override func addViews() {
    [videoView, titleLabel].forEach {
      addSubview($0)
    }
  }
  
  override func anchorViews() {
    videoView
      .anchorTop(topAnchor, 0.0)
      .anchorLeft(leftAnchor, 0.0)
      .anchorRight(rightAnchor, 0.0)
    
    titleLabel
      .anchorTop(videoView.bottomAnchor, 0.0)
      .anchorLeft(leftAnchor, 0.0)
      .anchorRight(rightAnchor, 0.0)
      .anchorBottom(bottomAnchor, 0.0)
      .anchorHeight(20.0)
  }
  
  override func configureViews() {
    titleLabel.textAlignment = .left
    titleLabel.numberOfLines = 0
    titleLabel.backgroundColor = .white
  }
}
