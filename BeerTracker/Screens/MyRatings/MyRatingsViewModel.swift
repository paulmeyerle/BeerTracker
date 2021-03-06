//
//  MyRatingsViewModel.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/10/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import Foundation
import XCoordinator

final class MyRatingsViewModel: ObservableObject {
    private let provider: MyRatingsProvider
    private var disposeBag = Set<AnyCancellable>()
    private let onLoad = PassthroughSubject<Void, Never>()
    
    private let router: UnownedRouter<MyRatingsViewEvent>
    
    // MARK: Inputs
    func fetch() {
        onLoad.send(())
    }
    
    func onModelSelected(_ model: MyRatingsItemViewModel) {
        router.trigger(.ratingIsPicked(id: model.id))
    }
    
    // MARK: Outputs
    let titleText: String = "My Ratings"
    @Published var cellViewModels: [MyRatingsItemViewModel] = []
    @Published var isLoading: Bool = false
    
    private lazy var fetchTriggerPublisher: AnyPublisher = {
        onLoad
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
    
    private lazy var cellViewModelsPublisher: AnyPublisher<[MyRatingsItemViewModel], Never> = {
        responsePublisher
            .map { result -> [MyRatingsItemViewModel] in
                guard case let .success(data) = result,
                    let ratings = data.myRatings else { return [] }
                return ratings.compactMap { MyRatingsItemViewModel(rating: $0) }
            }
            .eraseToAnyPublisher()
    }()
    
    init(provider: MyRatingsProvider, router: UnownedRouter<MyRatingsViewEvent>) {
        self.provider = provider
        self.router = router
            
        isLoadingPublisher
            .assign(to: \.isLoading, on: self)
            .store(in: &disposeBag)
        
        cellViewModelsPublisher
            .assign(to: \.cellViewModels, on: self)
            .store(in: &disposeBag)
    }
}
