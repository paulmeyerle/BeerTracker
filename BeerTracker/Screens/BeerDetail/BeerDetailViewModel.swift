//
//  BeerDetailViewModel.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/20/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import XCoordinator

final class BeerDetailViewModel: ObservableObject {
    private var disposeBag = Set<AnyCancellable>()
    private let id: String
    private let provider: BeerProvider
    private let router: UnownedRouter<BeerDetailViewEvent>
    
    // Inputs
    private let onLoad = PassthroughSubject<Void, Never>()
    func fetch() {
        onLoad.send(())
    }
    
    // Outputs
    
    @Published var isLoading: Bool = false
    @Published var imageURL: URL? = nil
    @Published var nameText: String = ""
    @Published var beerStyleText: String = ""
    @Published var breweryNameText: String = ""
    
    private lazy var fetchTriggerPublisher: AnyPublisher = {
        onLoad
            .eraseToAnyPublisher()
    }()
    
    private lazy var responsePublisher: AnyPublisher = {
        fetchTriggerPublisher
            .map {
                self.provider.fetchBeer(id: self.id)
                    .map { Result<BeerQuery.Data, Error>.success($0) }
                    .catch { Just(Result<BeerQuery.Data, Error>.failure($0)) }
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
    
    private lazy var imageURLPublisher: AnyPublisher<URL?, Never> = {
        responsePublisher
            .map { result -> URL? in
                switch result {
                case .success(let data):
                    guard let url = data.beer?.imageUrl else { return nil }
                    return URL(string: url)
                case .failure:
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }()
    
    private lazy var nameTextPublisher: AnyPublisher = {
        responsePublisher
            .map { result -> String in
                switch result {
                case .success(let data):
                    return data.beer?.name ?? ""
                case .failure:
                    return ""
                }
            }
            .eraseToAnyPublisher()
    }()
    
    private lazy var breweryNameTextPublisher: AnyPublisher = {
        responsePublisher
            .map { result -> String in
                switch result {
                case .success(let data):
                    return data.beer?.brewery.name ?? ""
                case .failure:
                    return ""
                }
            }
            .eraseToAnyPublisher()
    }()
    
    private lazy var beerStyleTextPublisher: AnyPublisher = {
        responsePublisher
            .map { result -> String in
                switch result {
                case .success(let data):
                    return data.beer?.type ?? ""
                case .failure:
                    return ""
                }
            }
            .eraseToAnyPublisher()
    }()
    
    init(id: String,
         provider: BeerProvider,
         router: UnownedRouter<BeerDetailViewEvent>) {
        self.id = id
        self.provider = provider
        self.router = router
        
        isLoadingPublisher
            .assign(to: \.isLoading, on: self)
            .store(in: &disposeBag)
        
        imageURLPublisher
            .assign(to: \.imageURL, on: self)
            .store(in: &disposeBag)
        
        nameTextPublisher
            .assign(to: \.nameText, on: self)
            .store(in: &disposeBag)
        
        beerStyleTextPublisher
            .assign(to: \.beerStyleText, on: self)
            .store(in: &disposeBag)
        
        breweryNameTextPublisher
            .assign(to: \.breweryNameText, on: self)
            .store(in: &disposeBag)
    }
}
