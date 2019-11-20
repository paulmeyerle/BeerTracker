//
//  BeerProvider.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/20/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import Foundation

protocol BeerProvider {
    func fetchBeer(id: UUID) -> AnyPublisher<BeerQuery.Data, Error>
}
