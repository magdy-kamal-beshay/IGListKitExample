//
//  DetailsModel.swift
//  IGListExample
//
//  Created by temporaryadmin on 16.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import Foundation

struct DetailsModel: Codable {
  let title: String
  let image: String
  let menus: [MenuModel]
}

struct MenuModel: Codable {
  let title: String
  let subtitle: String
}
