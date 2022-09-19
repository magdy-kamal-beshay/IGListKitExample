//
//  EnableCollectionViewCell.swift
//  IGListExample
//
//  Created by temporaryadmin on 19.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import UIKit

class EnableCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var switchComp: UISwitch!
  var switchTapped: (() -> Void)?

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func update(switchVal: Bool?) {
    switchComp.isOn = switchVal ?? switchComp.isOn
  }
  
  @IBAction func switchTapped(_ sender: UISwitch) {
    switchTapped?()
  }
}
