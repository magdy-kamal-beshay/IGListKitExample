//
//  EnablePresenter.swift
//  IGListExample
//
//  Created by temporaryadmin on 19.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import Foundation
import Combine
import IGListKit

class EnablePresenter: NSObject, Presenter {
  
  struct Output {
    let switchVal: AnyPublisher<Bool, Never>
  }
  
  struct Action {
    let switchPressed = PassthroughSubject<Bool, Never>()
  }
  
  var input: Inputs
  var output: Output
  var actions: Actions
  let enableActions = Action()
  
  private let switchSubject = PassthroughSubject<Bool, Never>()
  private var disbosables = Set<AnyCancellable>()
  private(set) var info = DetailsInfoInput()
  private(set) var switchVal = true

  init(input: Inputs) {
    self.input = input
    self.output = Output(
      switchVal: switchSubject.eraseToAnyPublisher()
    )
    self.actions = Actions()
    super.init()
    initListeners()
    addActions()
  }
  
  private func initListeners() {
    input[.info]?
      .sink(receiveValue: {_ in
        self.switchSubject.send(self.switchVal)
      }).store(in: &disbosables)
  }
  
  func switchPressed() {
    switchVal = !switchVal
    switchSubject.send(switchVal)
    enableActions.switchPressed.send(switchVal)
  }
  private func addActions() {
    actions[.switchEnabled] = enableActions.switchPressed.map { $0 as Any }.eraseToAnyPublisher()
  }
  
  func makeSectionController() -> ListSectionController {
    EnableSectionController()
  }
}
