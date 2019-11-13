//
//  MyRatingsCellViewModel.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/10/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Foundation

final class MyRatingsCellViewModel: Identifiable, ObservableObject {
    let id: UUID
    
    @Published var imageURL: URL
    @Published var nameText: String = ""
    @Published var breweryText: String = ""
    @Published var locationText: String = ""
    @Published var ratingText: String = ""
    
    convenience init(rating: MyRatingsQuery.Data.MyRating) {
        self.init(id: UUID(),
                  nameText: rating.beer.name ?? "",
                  breweryText: rating.beer.brewery.name ?? "",
                  locationText: rating.beer.brewery.location,
                  imageURL: URL(string: rating.beer.imageUrl ?? "")!,
                  ratingText: rating.ratingText)
    }
    
    init(id: UUID,
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
