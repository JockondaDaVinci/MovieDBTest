//
//  CollectionViewCellView.swift
//  MovieDBTest
//
//  Created by Maksym Balukhtin on 27.05.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

class CollectionViewCellView: BuildableView {
  let imageView = UIImageView()
  let titleLabel = UILabel()
  let favouriteButton = UIButton()
  
  override func addViews() {
    [imageView, titleLabel, favouriteButton].forEach {
      addSubview($0)
    }
  }
  
  override func anchorViews() {
    imageView
      .anchorTop(topAnchor, 10.0)
      .anchorLeft(leftAnchor, 10.0)
      .anchorRight(rightAnchor, 10.0)
      .anchorEqualHeight(imageView.widthAnchor)
    
    titleLabel
      .anchorTop(imageView.bottomAnchor, 10.0)
      .anchorLeft(imageView.leftAnchor, 0.0)
      .anchorRight(rightAnchor, 0.0)
      .anchorBottom(bottomAnchor, 10.0)
    
    favouriteButton
      .anchorTop(topAnchor, 10.0)
      .anchorRight(rightAnchor, 10.0)
      .anchorHeight(30.0)
      .anchorEqualWidth(favouriteButton.heightAnchor)
  }
  
  override func configureViews() {
    backgroundColor = .white
    
    imageView.contentMode = .scaleAspectFit
    
    titleLabel.textAlignment = .center
    titleLabel.textColor = .black
    titleLabel.numberOfLines = 0
    
    favouriteButton.setTitle("Fav", for: .normal)
    favouriteButton.setTitleColor(.black, for: .normal)
  }
}
