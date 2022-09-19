//
//  DetailsView.swift
//  IGListExample
//
//  Created by temporaryadmin on 16.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import Foundation
import UIKit

class DetailsView: UIView {
  
  let collectionView: UICollectionView = {
    let view = UICollectionView(
      frame: .zero,
      collectionViewLayout: UICollectionViewFlowLayout())
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.showsHorizontalScrollIndicator = false
    view.showsVerticalScrollIndicator = false
    return view
  }()
  
  override func didMoveToWindow() {
    super.didMoveToWindow()
    constructHierarchy()
    activateConstraints()
  }
  
  func constructHierarchy() {
    addSubview(collectionView)
  }
  
  func activateConstraints() {
    activateConstraintsCollectionView()
  }
  
  func activateConstraintsCollectionView() {
    NSLayoutConstraint.activate([
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}
