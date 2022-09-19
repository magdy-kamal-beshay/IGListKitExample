//
//  MenuCollectionViewCell.swift
//  IGListExample
//
//  Created by temporaryadmin on 19.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func update(menu: MenuInput?) {
    titleLabel.text = menu?.title
    subtitleLabel.text = menu?.subtitle
  }
}
