//
//  RatingDetailViewModel.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/20/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import XCoordinator

final class RatingDetailViewModel: ObservableObject {
    private let router: UnownedRouter<RatingDetailViewEvent>
    
    init(ratingId: String, router: UnownedRouter<RatingDetailViewEvent>) {
        self.router = router
    }
}
