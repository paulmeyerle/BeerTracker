//
//  HomeProvider.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/12/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine

protocol HomeProvider {
    func fetchHomeBreweries() -> AnyPublisher<HomeBeweriesQuery.Data, Error>
}
