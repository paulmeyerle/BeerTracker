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
    
    @Published var imageURL: URL
    @Published var nameText: String = ""
    @Published var locationText: String = ""
    
    convenience init(brewery: HomeBeweriesQuery.Data.AllBrewery) {
        self.init(id: UUID(),
                  nameText: brewery.name ?? "",
                  locationText: brewery.location,
                  imageURL: URL(string: brewery.imageUrl ?? "")!)
    }
    
    init(id: UUID, nameText: String, locationText: String, imageURL: URL) {
        self.id = id
        self.nameText = nameText
        self.locationText = locationText
        self.imageURL = imageURL
    }
}

private extension HomeBeweriesQuery.Data.AllBrewery {
    var location: String {
        guard let county = county,
            let state = state else { return "" }
        
        return "\(county)/\(state)"
    }
}
