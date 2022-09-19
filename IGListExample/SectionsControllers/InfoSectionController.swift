//
//  InfoSectionController.swift
//  IGListExample
//
//  Created by temporaryadmin on 16.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import IGListKit
import Combine

class InfoSectionController: ListSectionController {
  
  var presenter: DetailsInfoPresenter?
  private(set) var disbosables = Set<AnyCancellable>()

  override init() {
    super.init()
    inset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
  }
  
  override func didUpdate(to object: Any) {
    presenter = (object as? DetailsInfoPresenter)
    subscribeForChanges()
  }
  
  private func updateContext() {
      collectionContext?.performBatch(animated: true, updates: { [weak self] in
          guard let self = self else { return }
          $0.reload(self)
      }, completion: nil)
  }
  
  private func subscribeForChanges() {
    guard let presenter = presenter else { return }
    presenter.output.info.sink(receiveValue: { _ in
      self.updateContext()
    }).store(in: &disbosables)
  }
  
  override func sizeForItem(at index: Int) -> CGSize {
    guard let context = collectionContext else {
      return .zero
    }
    let width = context.containerSize.width - 28
    return CGSize(width: width, height: 100)
  }
  
  override func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext?
      .dequeueReusableCell(withNibName: "InfoCollectionViewCell", bundle: nil, for: self, at: index)
    as! InfoCollectionViewCell
    cell.update(info: presenter?.info, isAddEnabled: presenter?.isAddEnabled)
    cell.buttonTapped = { [weak self] in
      guard let self = self else { return }
      self.presenter?.addButtonPressed()
    }
    return cell
  }
}
