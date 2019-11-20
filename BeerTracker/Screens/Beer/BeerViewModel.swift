//
//  BeerViewModel.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/20/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import Foundation

final class BeerViewModel: ObservableObject {
    private let provider: BeerProvider
    
    init(beerId: UUID, provider: BeerProvider) {
        self.provider = provider
    }
}
