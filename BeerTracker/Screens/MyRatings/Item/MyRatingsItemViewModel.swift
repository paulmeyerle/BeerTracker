//
//  MyRatingsItemViewModel.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/10/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Foundation

final class MyRatingsItemViewModel: Identifiable, ObservableObject {
    let id: String
    
    @Published var imageURL: URL
    @Published var nameText: String = ""
    @Published var breweryText: String = ""
    @Published var locationText: String = ""
    @Published var ratingText: String = ""
    
    convenience init?(rating: MyRatingsQuery.Data.MyRating) {
        guard let id = rating.id,
            let beerName = rating.beer.name,
            let breweryName = rating.beer.brewery.name,
            let urlString = rating.beer.imageUrl,
            let url = URL(string: urlString) else { return nil }
        
        self.init(id: id,
                  nameText: beerName,
                  breweryText: breweryName,
                  locationText: rating.beer.brewery.location,
                  imageURL: url,
                  ratingText: rating.ratingText)
    }
    
    init(id: String,
         nameText: String,
         breweryText: String,
         locationText: String,
         imageURL: URL,
         ratingText: String) {
        self.id = id
        self.nameText = nameText
        self.breweryText = breweryText
        self.locationText = locationText
        self.imageURL = imageURL
        self.ratingText = ratingText
    }
}

extension MyRatingsItemViewModel: Equatable {
    static func == (lhs: MyRatingsItemViewModel, rhs: MyRatingsItemViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}

private extension MyRatingsQuery.Data.MyRating {
    var ratingText: String {
        guard let rating = rating else { return "Not Rated" }
        return "\(String(rating.rounded()))/5"
    }
}

private extension MyRatingsQuery.Data.MyRating.Beer.Brewery {
    var location: String {
        guard let county = county,
            let state = state else { return "" }
        
        return "\(county)/\(state)"
    }
}
