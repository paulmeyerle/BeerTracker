//
//  MyRatingsItemViewModelTests.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 11/17/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import XCTest
@testable import BeerTracker

class MyRatingsItemViewModelTests: XCTestCase {
    
    func test_init_SHOULD_returnNil_WHEN_badBeerImageUrl() {
        let brewery = MyRatingsQuery.Data.MyRating.Beer.Brewery(name: "breweryName", state: "State", county: "County")
        let beer = MyRatingsQuery.Data.MyRating.Beer(imageUrl: " ",
                                                     name: "BeerName",
                                                     brewery: brewery)
        let rating = MyRatingsQuery.Data.MyRating(id: "id",
                                                  rating: 2,
                                                  beer: beer)
        let sut = MyRatingsItemViewModel(rating: rating)
        XCTAssertNil(sut)
    }
    
    func test_init_SHOULD_returnInstance_WHEN_nonNil() {
        let brewery = MyRatingsQuery.Data.MyRating.Beer.Brewery(name: "breweryName", state: "State", county: "County")
        let beer = MyRatingsQuery.Data.MyRating.Beer(imageUrl: "http://www.image.com",
                                                     name: "BeerName",
                                                     brewery: brewery)
        let rating = MyRatingsQuery.Data.MyRating(id: "id",
                                                  rating: 2,
                                                  beer: beer)
        let sut = try! XCTUnwrap(MyRatingsItemViewModel(rating: rating))
        
        XCTAssertEqual(sut.id, "id")
        XCTAssertEqual(sut.imageURL, URL(string: "http://www.image.com"))
        XCTAssertEqual(sut.nameText, "BeerName")
        XCTAssertEqual(sut.breweryText, "breweryName")
        XCTAssertEqual(sut.locationText, "County/State")
        XCTAssertEqual(sut.ratingText, "2.0/5")
    }
}
