//
//  MyRatingsViewEvent.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 12/16/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import XCoordinator

enum MyRatingsViewEvent: Route {
    case started
    case ratingIsPicked(id: String)
}