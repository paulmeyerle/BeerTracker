//
//  AppCoordinatorTests.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 12/20/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import XCTest
@testable import BeerTracker

class AppCoordinatorTests: XCTestCase {
    
    private var mockMyRatingsProvider: MockMyRatingsProvider!
    private var mockSearchProvider: MockSearchProvider!
    private var mockBeerProvider: MockBeerProvider!

    override func setUp() {
        mockMyRatingsProvider = MockMyRatingsProvider()
        mockSearchProvider = MockSearchProvider()
        mockBeerProvider = MockBeerProvider()
    }

    override func tearDown() {
        mockMyRatingsProvider = nil
        mockSearchProvider = nil
        mockBeerProvider = nil
    }
    
    func test_init_SHOULD_defaultToTabCoordinator() {
        let sut = AppCoordinator(myRatingsProvider: mockMyRatingsProvider,
                                 searchProvider: mockSearchProvider,
                                 beerProvider: mockBeerProvider)
        XCTAssertEqual(sut.children.count, 1)
        let child = try! XCTUnwrap(sut.children.first)
        XCTAssertTrue(child is TabCoordinator)
    }

    func test_prepareTransition_SHOULD_presentTabCoordinator_WITH_home_event() {
        let sut = AppCoordinator(myRatingsProvider: mockMyRatingsProvider,
                                 searchProvider: mockSearchProvider,
                                 beerProvider: mockBeerProvider)
        
        let result = sut.prepareTransition(for: .home)
        XCTAssertEqual(result.presentables.count, 1)
        let presentable = try! XCTUnwrap(result.presentables.first)
        XCTAssertTrue(presentable is TabCoordinator)
    }
    
    func test_prepareTransition_SHOULD_addChild_WITH_home_event() {
        let sut = AppCoordinator(myRatingsProvider: mockMyRatingsProvider,
                                 searchProvider: mockSearchProvider,
                                 beerProvider: mockBeerProvider)
        sut.trigger(.home)
        XCTAssertEqual(sut.children.count, 2)
        let child = try! XCTUnwrap(sut.children.last)
        XCTAssertTrue(child is TabCoordinator)
    }
}
