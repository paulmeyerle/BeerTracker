//
//  MockMyRatingsProvider.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 11/17/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

@testable import BeerTracker
import Combine

final class MockMyRatingsProvider: MyRatingsProvider {
    enum Errors: Error {
        case failure
    }
    
    var fetchMyRatingsResult: Result<MyRatingsQuery.Data, Error> = .failure(Errors.failure)
    private(set) var fetchMyRatingsCallCount: Int = 0
    func fetchMyRatings() -> AnyPublisher<MyRatingsQuery.Data, Error> {
        fetchMyRatingsCallCount += 1
        
        return Future<MyRatingsQuery.Data, Error> { (promise) in
            switch self.fetchMyRatingsResult {
            case .success(let data):
                promise(.success(data))
            case .failure(let error):
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
