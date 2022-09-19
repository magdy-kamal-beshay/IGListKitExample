//
//  LocalDataSource.swift
//  IGListExample
//
//  Created by temporaryadmin on 16.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import Foundation
import Combine

class LocalDataSource: DataSource {
  let subscriber = PassthroughSubject<DetailsModel, Error>()
  func fetchItemDetails() -> AnyPublisher<DetailsModel, Error> {
    if let url = Bundle.main.url(forResource: "Details", withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let jsonData = try decoder.decode(DetailsModel.self, from: data)
        return Just(jsonData)
          .setFailureType(to: Error.self)
          .receive(on: DispatchQueue.main)
          .eraseToAnyPublisher()
      } catch {
        subscriber.send(completion: .finished)
      }
    }
    return subscriber.eraseToAnyPublisher()
  }
}
