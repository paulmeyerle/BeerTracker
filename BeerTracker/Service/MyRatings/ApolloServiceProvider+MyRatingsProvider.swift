//
//  ApolloServiceProvider+HomeProvider.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/12/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine

extension ApolloServiceProvider: MyRatingsProvider {
    func fetchMyRatings() -> AnyPublisher<MyRatingsQuery.Data, Error> {
        return client.fetch(query: MyRatingsQuery())
    }
}
