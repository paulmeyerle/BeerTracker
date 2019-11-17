//
//  MockSearchProvider.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 11/16/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

@testable import BeerTracker
import Combine

final class MockSearchProvider: SearchProvider {
    enum Errors: Error {
        case failure
    }
    
    var searchResult: Result<SearchBeersQuery.Data, Error> = .failure(Errors.failure)
    private(set) var searchCallCount: Int = 0
    private(set) var searchParamQuery: [String] = []
    func search(query: String) -> AnyPublisher<SearchBeersQuery.Data, Error> {
        searchCallCount += 1
        searchParamQuery.append(query)
        return Future<SearchBeersQuery.Data, Error> { (promise) in
            switch self.searchResult {
            case .success(let data):
                promise(.success(data))
            case .failure(let error):
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
