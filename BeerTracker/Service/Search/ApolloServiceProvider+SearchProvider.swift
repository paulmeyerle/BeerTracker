//
//  ApolloServiceProvider+SearchProvider.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/13/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine

extension ApolloServiceProvider: SearchProvider {
    func search(query: String) -> AnyPublisher<SearchBeersQuery.Data, Error> {
        return client.fetch(query: SearchBeersQuery(query: query))
    }
}
