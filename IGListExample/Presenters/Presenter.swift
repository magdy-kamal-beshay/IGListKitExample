//
//  Presenter.swift
//  IGListExample
//
//  Created by temporaryadmin on 16.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import Foundation
import Combine
import IGListKit

typealias Inputs = [DetailsInputs: AnyPublisher<Any, Never>]
typealias Actions = [DetailsActions: AnyPublisher<Any, Never>]

enum DetailsActions: Hashable {
  case addPressed
  case switchEnabled
  static public func == (lhs: DetailsActions, rhs: DetailsActions) -> Bool {
    return lhs.hashValue == rhs.hashValue
  }
}

public enum DetailsInputs: Hashable {
  case info
  case addNewRow
  case menuList
  case enabledChange
  
  static public func == (lhs: DetailsInputs, rhs: DetailsInputs) -> Bool {
    return lhs.hashValue == rhs.hashValue
  }
}

protocol Presenter: NSObject {
  var input: Inputs { get }
  var actions: Actions { get }
  func makeSectionController() -> ListSectionController
}

extension NSObject: ListDiffable {
  public func diffIdentifier() -> NSObjectProtocol {
    self
  }
  public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    isEqual(object)
  }
}
