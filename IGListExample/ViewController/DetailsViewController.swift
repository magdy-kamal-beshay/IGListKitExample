//
//  DetailsViewController.swift
//  IGListExample
//
//  Created by temporaryadmin on 17.09.22.
//  Copyright © 2022 OwnProjects. All rights reserved.
//

import Foundation
import UIKit
import Combine
import IGListKit

class DetailsViewController: UIViewController {
  
  lazy var adapter: ListAdapter = {
    return ListAdapter(
      updater: ListAdapterUpdater(),
      viewController: self,
      workingRangeSize: 0)
  }()
  
  var viewModel: DetailsViewModel!
  private(set) var disbosables = Set<AnyCancellable>()
  let makeViewModel: () -> DetailsViewModel
  
  init(viewModelFactory: @escaping () -> DetailsViewModel) {
    self.makeViewModel = viewModelFactory
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var prefersStatusBarHidden: Bool {
    return false
  }
  
  override func loadView() {
    view = DetailsView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = makeViewModel()
    subscribe(to: viewModel.output.update)
    setupView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  private func setupView() {
    view.backgroundColor = .white
    adapter.collectionView = (view as? DetailsView)?.collectionView
    adapter.dataSource = self
    viewModel.fetchDetails()
  }
}

// MARK: - Subscribtions
extension DetailsViewController {
  
  func subscribe(to observable: AnyPublisher<Void, Never>) {
    observable.sink { _ in
      self.adapter.performUpdates(animated: true)
    }.store(in: &disbosables)
  }
}

extension DetailsViewController: ListAdapterDataSource {

  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    viewModel.presentations
  }

  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    guard let presenterObject = object as? Presenter else { return ListSectionController() }
    let index = viewModel.presentations.firstIndex { $0 == presenterObject }
    guard let index = index else {
      return ListSectionController()
    }
    return viewModel.presentations[index].makeSectionController()
  }

  func emptyView(for listAdapter: ListAdapter) -> UIView? {
    nil
  }
}

