//
//  SearchResultViewModelTests.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 11/17/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import XCTest
@testable import BeerTracker

class SearchResultViewModelTests: XCTestCase {
    
    // MARK: Constructor

    func test_init_SHOULD_returnNil_WHEN_badUrl() {
        let result = SearchBeersQuery.Data.SearchBeer(id: "id",
                                                      imageUrl: " ",
                                                      name: "beerName",
                                                      type: "beerType",
                                                      brewery: SearchBeersQuery.Data.SearchBeer.Brewery(name: "brewereyName"))
        let sut = SearchResultViewModel(result: result)
        XCTAssertNil(sut)
    }
    
    func test_init_SHOULD_returnInstance() {
        let result = SearchBeersQuery.Data.SearchBeer(id: "id",
                                                      imageUrl: "http://www.image.com",
                                                      name: "beerName",
                                                      type: "beerType",
                                                      brewery: SearchBeersQuery.Data.SearchBeer.Brewery(name: "breweryName"))
        let sut = try! XCTUnwrap(SearchResultViewModel(result: result))
        XCTAssertEqual(sut.id, "id")
        XCTAssertEqual(sut.imageURL, URL(string: "http://www.image.com"))
        XCTAssertEqual(sut.nameText, "beerName")
        XCTAssertEqual(sut.beerStyleText, "beerType")
        XCTAssertEqual(sut.breweryNameText, "breweryName")
    }

}
