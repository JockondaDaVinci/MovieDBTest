//
//  UICollectionView+Extensions.swift
//  OrgTech
//
//  Created by Maksym Balukhtin on 22.04.2020.
//  Copyright © 2020 Maksym Balukhtin. All rights reserved.
//

import UIKit

extension UICollectionView {
  func dequeue<CellType: UICollectionViewCell>(cellOfType type: CellType.Type, for indexPath: IndexPath) -> CellType? {
    return dequeueReusableCell(withReuseIdentifier: type.reuseId, for: indexPath) as? CellType
  }
  
  func register<CellType: UICollectionViewCell>(cell: CellType.Type) {
    register(cell, forCellWithReuseIdentifier: cell.reuseId)
  }
  
  
  enum SupplementaryElementType {
    case header
    case footer
  }
  
  func register<SupplementaryType: UICollectionReusableView>(supplementaryCell: SupplementaryType.Type, for type: SupplementaryElementType) {
    var kind = ""
    switch type {
    case .header:
      kind = UICollectionView.elementKindSectionHeader
    case .footer:
      kind = UICollectionView.elementKindSectionFooter
    }
    register(supplementaryCell, forSupplementaryViewOfKind: kind, withReuseIdentifier: supplementaryCell.reuseId)
  }
}
