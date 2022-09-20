//
//  DetailsInfoPresenter.swift
//  IGListExample
//
//  Created by temporaryadmin on 16.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import Foundation
import Combine
import IGListKit

struct DetailsInfoInput {
  let title: String
  let image: String
}

extension DetailsInfoInput {
  
  init() {
    title = ""
    image = ""
  }
}

class DetailsInfoPresenter: NSObject, Presenter {
  
  struct Output {
    let info: AnyPublisher<(Void, Bool), Never>
  }
  
  struct Action {
    let addPressed = PassthroughSubject<Void, Never>()
    let detailsLoaded = PassthroughSubject<Void, Never>()
  }
  
  var input: Inputs
  var output: Output
  var actions: Actions
  let infoActions = Action()
  private(set) var isAddEnabled = true
  
  private let infoSubject = PassthroughSubject<(Void, Bool), Never>()
  private var disbosables = Set<AnyCancellable>()
  private(set) var info = DetailsInfoInput()

  init(input: Inputs) {
    self.input = input
    self.output = Output(
      info: infoSubject.eraseToAnyPublisher()
    )
    self.actions = Actions()
    super.init()
    initListeners()
    addActions()
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
      self.info = DetailsInfoInput(title: "Restaurant Details Page", image: "")
      self.infoActions.detailsLoaded.send()
      self.infoSubject.send(((), self.isAddEnabled))
    }
  }
  
  private func initListeners() {
    input[.info]?
      .map { $0 as? DetailsInfoInput }
      .sink(receiveValue: { val in
        guard let val = val else { return }
        self.info = val
        self.infoSubject.send(((), self.isAddEnabled))
      }).store(in: &disbosables)
    
    input[.enabledChange]?
      .map { $0 as? Bool }
      .sink(receiveValue: { val in
        guard let val = val else { return }
        self.isAddEnabled = val
        self.infoSubject.send(((), self.isAddEnabled))
      }).store(in: &disbosables)
  }
  
  func addButtonPressed() {
    infoActions.addPressed.send()
  }
  private func addActions() {
    actions[.addPressed] = infoActions.addPressed.map { $0 as Any }.eraseToAnyPublisher()
    actions[.detailsLoaded] = infoActions.detailsLoaded.map { $0 as Any }.eraseToAnyPublisher()
  }
  
  func makeSectionController() -> ListSectionController {
    InfoSectionController()
  }
}
