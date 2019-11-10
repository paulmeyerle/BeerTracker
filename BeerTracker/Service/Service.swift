//
//  Service.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/9/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Apollo
import Combine
import Foundation

protocol HomeProvider {
    func fetchHomeBreweries() -> AnyPublisher<HomeBeweriesQuery.Data, Error>
}

final class ApolloServiceProvider {
    private let client: ApolloClient
    
    init(client: ApolloClient = ApolloClient(url: URL(string: "http://localhost:9002/graphql")!)) {
        self.client = client
    }
    
}

extension ApolloServiceProvider: HomeProvider {
    func fetchHomeBreweries() -> AnyPublisher<HomeBeweriesQuery.Data, Error> {
        return client.fetch(query: HomeBeweriesQuery())
            
    }
}

// MARK: ApolloClient+Rx
extension ApolloClient {
    func fetch<Query: GraphQLQuery>(query: Query,
                                    cachePolicy: CachePolicy = .returnCacheDataElseFetch,
                                    context: UnsafeMutableRawPointer? = nil,
                                    queue: DispatchQueue = DispatchQueue.main) -> AnyPublisher<Query.Data, Error> {
        
        return Future<Query.Data, Error> { promise in
            self.fetch(query: query, cachePolicy: cachePolicy, context: context, queue: queue) { (result) in
                switch result {
                case let .success(data):
                    if let thing = data.data {
                        promise(.success(thing))
                    }
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
