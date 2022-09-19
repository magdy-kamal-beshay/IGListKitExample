//
//  DetailsViewModel.swift
//  IGListExample
//
//  Created by temporaryadmin on 17.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import Foundation
import Combine

class DetailsViewModel {
  
  struct Output {
    let update: AnyPublisher<Void, Never>
  }
  
  let repository: DataSource
  private(set) var presentations = [Presenter]()
  var output: Output
  private(set) var disbosables = Set<AnyCancellable>()
  // Factories
  private let makeDetailsInfoPresenter: (Inputs) -> DetailsInfoPresenter
  private let makeMenuListPresenter: (Inputs) -> MenuListPresenter
  private let makeEnablePresenter: (Inputs) -> EnablePresenter
  private let updateSubject = PassthroughSubject<Void, Never>()

  init(repository: DataSource,
       detailsInfoPresenterFactory: @escaping (Inputs) -> DetailsInfoPresenter,
       menuListPresenterFactory: @escaping (Inputs) -> MenuListPresenter,
       enablePresenterFactory: @escaping (Inputs) -> EnablePresenter) {
    self.repository = repository
    self.makeDetailsInfoPresenter = detailsInfoPresenterFactory
    self.makeMenuListPresenter = menuListPresenterFactory
    self.makeEnablePresenter = enablePresenterFactory
    self.output = Output(update: updateSubject.eraseToAnyPublisher())
  }
  
  func fetchDetails() {
    repository.fetchItemDetails().sink { _ in } receiveValue: { response in
      self.setupPresenters(details: response)
      self.updateSubject.send(())
    }.store(in: &disbosables)
  }
  
  private func setupPresenters(details: DetailsModel) {
    setupEnablePresenter()
    setupDetailsPresenter(details: details)
    setupMenuPresenter(details: details)
  }
  
  private func setupDetailsPresenter(details: DetailsModel) {
    let enableObservable = (presentations[0] as? EnablePresenter)?.actions[.switchEnabled] ?? Just(Void()).eraseToAnyPublisher()

    let info = DetailsInfoInput(title: details.title, image: details.image)
    let inputs = [
      DetailsInputs.info: Just(info as Any).eraseToAnyPublisher(),
      DetailsInputs.enabledChange: enableObservable
    ]
    let mediaPresenter = makeDetailsInfoPresenter(inputs)
    presentations.append(mediaPresenter)
  }
  
  private func setupEnablePresenter() {
    let enablePresenter = makeEnablePresenter([:])
    presentations.append(enablePresenter)
  }
  
  private func setupMenuPresenter(details: DetailsModel) {
    let addObservable = (presentations[1] as? DetailsInfoPresenter)?.actions[.addPressed] ?? Just(Void()).eraseToAnyPublisher()
    let inputs = [
      DetailsInputs.info: Just(details.menus as Any).eraseToAnyPublisher(),
      DetailsInputs.addNewRow: addObservable
    ]
    let menuPresenter = makeMenuListPresenter(inputs)
    presentations.append(menuPresenter)
  }
  
}
