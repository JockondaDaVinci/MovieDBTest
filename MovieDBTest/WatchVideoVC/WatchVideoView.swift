//
//  WatchVideoView.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class WatchVideoView: BuildableView {
  let videoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  
  private let headerStackView = UIStackView()
  let titleLabel = UILabel()
  let yearLabel = UILabel()
  let descTextView = UITextView()
  
  override func addViews() {
    [titleLabel, yearLabel].forEach {
      headerStackView.addArrangedSubview($0)
    }
    
    [videoCollectionView, headerStackView, descTextView].forEach {
      addSubview($0)
    }
  }
  
  override func anchorViews() {
    videoCollectionView
      .anchorTop(safeAreaLayoutGuideAnyIOS.topAnchor, 0.0)
      .anchorLeft(leftAnchor, 0.0)
      .anchorRight(rightAnchor, 0.0)
      .anchorHeight(250.0)
    
    headerStackView
      .anchorTop(videoCollectionView.bottomAnchor, 0.0)
      .anchorLeft(leftAnchor, 0.0)
      .anchorRight(rightAnchor, 0.0)
      .anchorHeight(30.0)
    
    descTextView
      .anchorTop(headerStackView.bottomAnchor, 0.0)
      .anchorLeft(leftAnchor, 0.0)
      .anchorRight(rightAnchor, 0.0)
      .anchorBottom(bottomAnchor, 0.0)
  }
  
  override func configureViews() {
    backgroundColor = .white
    
    headerStackView.axis = .horizontal
    headerStackView.alignment = .fill
    headerStackView.distribution = .fillEqually
    
    [titleLabel, yearLabel].forEach {
      $0.textAlignment = .center
      $0.numberOfLines = 0
    }
    
    descTextView.isUserInteractionEnabled = false
    descTextView.font = .systemFont(ofSize: 17.0)
    
    videoCollectionView.allowsSelection = false
    videoCollectionView.showsHorizontalScrollIndicator = false
    videoCollectionView.showsHorizontalScrollIndicator = false
    videoCollectionView.register(cell: VideoCell.self)
    (videoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
    videoCollectionView.bounces = false
  }
}
