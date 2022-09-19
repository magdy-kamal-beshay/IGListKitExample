//
//  DataSource.swift
//  IGListExample
//
//  Created by temporaryadmin on 16.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import Combine

protocol DataSource {
    func fetchItemDetails() -> AnyPublisher<DetailsModel, Error>
}



