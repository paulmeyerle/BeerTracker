//
//  ApolloServiceProvider+BeerProvider.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/20/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import Foundation

extension ApolloServiceProvider: BeerProvider {
    func fetchBeer(id: UUID) -> AnyPublisher<BeerQuery.Data, Error> {
        return client.fetch(query: BeerQuery(beerId: id.uuidString))
    }
}
