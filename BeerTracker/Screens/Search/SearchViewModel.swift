//
//  SearchViewModel.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/13/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import Foundation
import XCoordinator

final class SearchViewModel: ObservableObject {
    private let router: UnownedRouter<SearchViewEvent>
    private let provider: SearchProvider
    private var disposeBag = Set<AnyCancellable>()
    private let mainDispatchQueue: DispatchQueue
    private let globalDispatchQueue: DispatchQueue
    
    // MARK: Inputs
    @Published var searchQuery: String = ""
    
    // MARK: Outputs
    let titleText: String = "Search"
    let placeholderText: String = "Search for beers here"
    @Published var resultViewModels: [SearchResultViewModel] = []
    
    private lazy var fetchTriggerPublisher: AnyPublisher<String, Never> = {
        $searchQuery
            .debounce(for: .milliseconds(250), scheduler: globalDispatchQueue)
            .filter { $0.count >= 3 }
            .eraseToAnyPublisher()
    }()
    
    private lazy var searchResponsePublisher: AnyPublisher<Result<SearchBeersQuery.Data, Error>, Never> = {
        let provider = self.provider
        return fetchTriggerPublisher
            .subscribe(on: globalDispatchQueue)
            .map {
                provider.search(query: $0)
                    .map { Result<SearchBeersQuery.Data, Error>.success($0) }
                    .catch { Just(Result<SearchBeersQuery.Data, Error>.failure($0)) }
            }
            .switchToLatest()
            .share()
            .eraseToAnyPublisher()
    }()
    
    private lazy var resultViewModelsPublisher: AnyPublisher = {
        searchResponsePublisher
            .map({ (result) -> [SearchResultViewModel] in
                guard case let .success(data) = result,
                    let results = data.searchBeers else { return [] }
                return results.compactMap { SearchResultViewModel(result: $0) }
            })
            .eraseToAnyPublisher()
    }()
    
    init(provider: SearchProvider,
         router: UnownedRouter<SearchViewEvent>,
         mainDispatchQueue: DispatchQueue = DispatchQueue.main,
         globalDispatchQueue: DispatchQueue = DispatchQueue.global()) {
        self.provider = provider
        self.router = router
        self.mainDispatchQueue = mainDispatchQueue
        self.globalDispatchQueue = globalDispatchQueue
        
        resultViewModelsPublisher
            .assign(to: \.resultViewModels, on: self)
            .store(in: &disposeBag)
    }
    
    func onModelSelected(_ model: SearchResultViewModel) {
        router.trigger(.beerIsPicked(id: model.id))
    }
}
