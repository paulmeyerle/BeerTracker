//
//  HomeCellViewModel.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/10/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Foundation

final class HomeCellViewModel: Identifiable, ObservableObject {
    let id: UUID
    
    @Published var nameText: String = ""
    @Published var locationText: String = ""
    
    init(brewery: HomeBeweriesQuery.Data.AllBrewery) {
        id = UUID()
        nameText = brewery.name ?? ""
        locationText = brewery.location
    }
}

private extension HomeBeweriesQuery.Data.AllBrewery {
    var location: String {
        guard let county = county,
            let state = state else { return "" }
        
        return "\(county)/\(state)"
    }
}
