//
//  MockBeerProvider.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 12/20/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

@testable import BeerTracker
import Combine

final class MockBeerProvider: BeerProvider {
    enum Errors: Error {
        case failure
    }
    
    var fetchBeerResult: Result<BeerQuery.Data, Error> = .failure(Errors.failure)
    private(set) var fetchBeerCallCount: Int = 0
    private(set) var fetchBeerParamId = [String]()
    func fetchBeer(id: String) -> AnyPublisher<BeerQuery.Data, Error> {
        fetchBeerCallCount += 1
        fetchBeerParamId.append(id)
        return Future<BeerQuery.Data, Error> { (promise) in
            switch self.fetchBeerResult {
            case .success(let data):
                promise(.success(data))
            case .failure(let error):
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
