//
//  BeerViewModel.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/20/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import XCoordinator

final class BeerViewModel: ObservableObject {
    private let provider: BeerProvider
    private let router: UnownedRouter<BeerViewEvent>
    
    init(beerId: String, provider: BeerProvider, router: UnownedRouter<BeerViewEvent>) {
        self.provider = provider
        self.router = router
    }
}
