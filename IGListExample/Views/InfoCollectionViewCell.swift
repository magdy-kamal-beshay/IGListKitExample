//
//  InfoCollectionViewCell.swift
//  IGListExample
//
//  Created by temporaryadmin on 17.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var addButton: UIButton!
  @IBOutlet weak var vendorImageView: UIImageView!
  
  var buttonTapped: (() -> Void)?
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func update(info: DetailsInfoInput?, isAddEnabled: Bool?) {
    titleLabel.text = info?.title
    addButton.isEnabled = isAddEnabled ?? addButton.isEnabled
  }

  @IBAction func buttonTapped(_ sender: UIButton) {
    buttonTapped?()
  }
}
