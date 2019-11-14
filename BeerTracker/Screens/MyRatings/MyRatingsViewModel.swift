//
//  MyRatingsViewModel.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/10/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import Foundation

final class MyRatingsViewModel: ObservableObject {
    private let provider: MyRatingsProvider
    private var disposeBag = Set<AnyCancellable>()
    
    // MARK: Inputs
    let onLoad = PassthroughSubject<Void, Never>()
    let onReload = PassthroughSubject<Void, Never>()
    
    // MARK: Outputs
    @Published var cellViewModels: [MyRatingsItemViewModel] = []
    @Published var isLoading: Bool = false
    
    private lazy var fetchTriggerPublisher: AnyPublisher = {
        Publishers.Merge(onLoad, onReload)
            .prepend(())
            .eraseToAnyPublisher()
    }()
    
    private lazy var responsePublisher: AnyPublisher = {
        fetchTriggerPublisher
            .map {
                self.provider.fetchMyRatings()
                    .map { Result<MyRatingsQuery.Data, Error>.success($0) }
                    .catch { Just(Result<MyRatingsQuery.Data, Error>.failure($0)) }
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
            .compactMap({ (result) -> [MyRatingsItemViewModel]? in
                guard case let .success(data) = result,
                    let ratings = data.myRatings else { return nil }
                return ratings.compactMap { MyRatingsItemViewModel(rating: $0) }
            })
            .eraseToAnyPublisher()
    }()
    
    init(provider: MyRatingsProvider) {
        self.provider = provider
            
        isLoadingPublisher
            .assign(to: \.isLoading, on: self)
            .store(in: &disposeBag)
        
        cellViewModelsPublisher
            .assign(to: \.cellViewModels, on: self)
            .store(in: &disposeBag)
    }
}
