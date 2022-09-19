//
//  MenuListPresenter.swift
//  IGListExample
//
//  Created by temporaryadmin on 16.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import Foundation
import Combine
import IGListKit

struct MenuInput {
  let title: String
  let subtitle: String
}

extension MenuInput {
  
  init() {
    title = ""
    subtitle = ""
  }
}

class MenuListPresenter: NSObject, Presenter {
  
  struct Output {
    let menu: AnyPublisher<Void, Never>
  }
  
  struct Action {
    let addEnabled = PassthroughSubject<Void, Never>()
  }
  
  var input: Inputs
  var output: Output
  var actions: Actions
  let menuActions = Action()
  
  private let menuSubject = PassthroughSubject<Void, Never>()
  private var disbosables = Set<AnyCancellable>()
  private(set) var menuList:[MenuInput] = []
  
  init(input: Inputs) {
    self.input = input
    self.output = Output(
      menu: menuSubject.eraseToAnyPublisher()
    )
    self.actions = Actions()
    super.init()
    initListeners()
  }
  
  private func initListeners() {
    input[.info]?
      .map { $0 as? [MenuModel] }
      .sink(receiveValue: { val in
        guard let val = val else { return }
        self.menuList = val.map { MenuInput(title: $0.title, subtitle: $0.subtitle) }
        self.menuSubject.send(())
      }).store(in: &disbosables)
    
    input[.addNewRow]?
      .sink(receiveValue: { val in
        self.menuList.append(self.menuList[0])
        self.menuSubject.send(())
      }).store(in: &disbosables)
    
  }
  
  func makeSectionController() -> ListSectionController {
    MenuSectionController()
  }
}
