//
//  SearchViewModel.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/13/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import Foundation

final class SearchViewModel: ObservableObject {
    private let provider: SearchProvider
    private var disposeBag = Set<AnyCancellable>()
    private let mainDispatchQueue: DispatchQueue
    private let globalDispatchQueue: DispatchQueue
    
    // MARK: Inputs
    @Published var searchQuery: String = ""
    
    // MARK: Outputs
    @Published var resultViewModels: [String] = []
    
    private lazy var fetchTriggerPublisher: AnyPublisher<String, Never> = {
        $searchQuery
            .debounce(for: .milliseconds(250), scheduler: globalDispatchQueue)
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
            .map { _ in ["one", "two", "three"] }
            .print("mapping")
            .eraseToAnyPublisher()
    }()
    
    init(provider: SearchProvider,
         mainDispatchQueue: DispatchQueue = DispatchQueue.main,
         globalDispatchQueue: DispatchQueue = DispatchQueue.global()) {
        self.provider = provider
        self.mainDispatchQueue = mainDispatchQueue
        self.globalDispatchQueue = globalDispatchQueue
        
        resultViewModelsPublisher
            .assign(to: \.resultViewModels, on: self)
            .store(in: &disposeBag)
    }
}
