//
//  HomeViewModel.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/10/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    private let homeProvider: HomeProvider
    private var disposeBag = Set<AnyCancellable>()
    
    // MARK: Inputs
    let onLoad = PassthroughSubject<Void, Never>()
    let onReload = PassthroughSubject<Void, Never>()
    
    // MARK: Outputs
    @Published var cellViewModels: [HomeCellViewModel] = []
    @Published var isLoading: Bool = false
    
    private lazy var fetchTriggerPublisher: AnyPublisher = {
        Publishers.Merge(onLoad, onReload)
            .prepend(())
            .eraseToAnyPublisher()
    }()
    
    private lazy var responsePublisher: AnyPublisher = {
        fetchTriggerPublisher
            .map {
                self.homeProvider.fetchHomeBreweries()
                    .map { Result<HomeBeweriesQuery.Data, Error>.success($0) }
                    .catch { Just(Result<HomeBeweriesQuery.Data, Error>.failure($0)) }
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .share()
            .eraseToAnyPublisher()
    }()
    
    private lazy var isLoadingPublisher: AnyPublisher = {
        Publishers.Merge(fetchTriggerPublisher.map { _ in true },
                                responsePublisher.map { _ in false })
            .removeDuplicates()
            .eraseToAnyPublisher()
    }()
    
    private lazy var cellViewModelsPublisher: AnyPublisher = {
        responsePublisher
            .compactMap({ (result) -> [HomeCellViewModel]? in
                guard case let .success(data) = result,
                    let breweries = data.allBreweries else { return nil }
                return breweries.map { HomeCellViewModel(brewery: $0) }
            })
            .eraseToAnyPublisher()
    }()
    
    init(homeProvider: HomeProvider) {
        self.homeProvider = homeProvider
            
        isLoadingPublisher
            .assign(to: \.isLoading, on: self)
            .store(in: &disposeBag)
        
        cellViewModelsPublisher
            .assign(to: \.cellViewModels, on: self)
            .store(in: &disposeBag)
    }
}
