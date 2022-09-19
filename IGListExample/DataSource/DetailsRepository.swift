//
//  File.swift
//  IGListExample
//
//  Created by temporaryadmin on 16.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import Combine

class DetailsRepository: DataSource {
  
  let localDataSource: DataSource
  
  init(localDataSource: DataSource) {
    self.localDataSource = localDataSource
  }
  
  func fetchItemDetails() -> AnyPublisher<DetailsModel, Error> {
    localDataSource.fetchItemDetails()
  }
}
