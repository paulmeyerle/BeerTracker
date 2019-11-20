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
        guard let url = URL(string: result.imageUrl) else { return nil }
        
        self.init(id: result.id,
                  imageURL: url,
                  nameText: result.name,
                  beerStyleText: result.type,
                  breweryNameText: result.brewery.name)
    }
}

extension SearchResultViewModel: Equatable {
    static func == (lhs: SearchResultViewModel, rhs: SearchResultViewModel) -> Bool {
        return lhs.id == rhs.id
    }
}
