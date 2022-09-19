//
//  DetailsDependencyContainer.swift
//  IGListExample
//
//  Created by temporaryadmin on 17.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import Foundation

class DetailsDependencyContainer {
  
  let repository: DataSource
  
  init() {
    func makeListingDetailsRepository() -> DetailsRepository {
      let localDataSource = makeLocalDataSource()
      return DetailsRepository(localDataSource: localDataSource)
    }
    
    func makeLocalDataSource() -> LocalDataSource {
      return LocalDataSource()
    }
    self.repository = makeListingDetailsRepository()
  }
  
  func makeDetailsViewModel() -> DetailsViewModel {
    let infoPresenterFactory = { inputs in
      return self.makeInfoPresenter(inputs: inputs)
    }
    let menuPresenterFactory = { inputs in
      return self.makeMenuPresenter(inputs: inputs)
    }
    let enablePresenterFactory = { inputs in
      return self.makeEnablePresenter(inputs: inputs)
    }
    
    return DetailsViewModel(repository: repository, detailsInfoPresenterFactory: infoPresenterFactory, menuListPresenterFactory: menuPresenterFactory, enablePresenterFactory: enablePresenterFactory)
  }
  
  func makeListingDetailsViewController() -> DetailsViewController {
    let detailsViewModelFactory = {
      return self.makeDetailsViewModel()
    }
    
    return DetailsViewController(viewModelFactory: detailsViewModelFactory)
  }
}


extension DetailsDependencyContainer {
  
  func makeInfoPresenter(inputs: Inputs) -> DetailsInfoPresenter {
    return DetailsInfoPresenter(input: inputs)
  }
  
  func makeMenuPresenter(inputs: Inputs) -> MenuListPresenter {
    return MenuListPresenter(input: inputs)
  }
  
  func makeEnablePresenter(inputs: Inputs) -> EnablePresenter {
    return EnablePresenter(input: inputs)
  }
}
