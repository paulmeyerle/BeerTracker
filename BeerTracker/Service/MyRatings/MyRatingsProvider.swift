//
//  MyRatingsProvider.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/12/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine

protocol MyRatingsProvider {
    func fetchMyRatings() -> AnyPublisher<MyRatingsQuery.Data, Error>
}
