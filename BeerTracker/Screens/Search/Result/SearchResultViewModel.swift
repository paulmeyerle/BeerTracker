//
//  SearchResultViewModel.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/14/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import Foundation

final class SearchResultViewModel: Identifiable, ObservableObject {
    let id: String
    
    @Published var imageURL: URL
    @Published var nameText: String
    @Published var beerStyleText: String
    @Published var breweryNameText: String
    
    init(id: String, imageURL: URL, nameText: String, beerStyleText: String, breweryNameText: String) {
        self.id = id
        self.imageURL = imageURL
        self.nameText = nameText
        self.beerStyleText = beerStyleText
        self.breweryNameText = breweryNameText
    }
    
    convenience init?(result: SearchBeersQuery.Data.SearchBeer) {
        guard let urlString = result.imageUrl,
            let id = result.id,
            let url = URL(string: urlString),
            let beerName = result.name,
            let beerStyle = result.type,
            let breweryName = result.brewery.name else { return nil }
        
        self.init(id: id,
                  imageURL: url,
                  nameText: beerName,
                  beerStyleText: beerStyle,
                  breweryNameText: breweryName)
    }
}

extension SearchResultViewModel: Equatable {
    static func == (lhs: SearchResultViewModel, rhs: SearchResultViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
