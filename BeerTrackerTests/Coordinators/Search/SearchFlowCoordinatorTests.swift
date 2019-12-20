//
//  SearchFlowCoordinatorTests.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 12/20/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI
import XCTest
@testable import BeerTracker

class SearchFlowCoordinatorTests: XCTestCase {

    private var mockRouter: MockRouter<SearchFlowCoordinatorRoute>!
    private var mockSearchProvider: MockSearchProvider!
    private var mockBeerProvider: MockBeerProvider!

    override func setUp() {
        mockRouter = MockRouter<SearchFlowCoordinatorRoute>()
        mockSearchProvider = MockSearchProvider()
        mockBeerProvider = MockBeerProvider()
    }

    override func tearDown() {
        mockRouter = nil
        mockSearchProvider = nil
        mockBeerProvider = nil
    }

    // MARK: SearchFlowCoordinator
    
    func test_SearchFlowCoordinator_SHOULD_defaultToSearch() {
        let sut = SearchFlowCoordinator(searchProvider: mockSearchProvider, beerProvider: mockBeerProvider)
        XCTAssertEqual(sut.children.count, 1)
        let child = try! XCTUnwrap(sut.children.first)
        XCTAssertTrue(child is SearchFlowCoordinator.SearchScreenCoordinator)
    }
    
    func test_SearchFlowCoordinator_prepareTransition_SHOULD_pushSearchScreen_WITH_search_event() {
        let sut = SearchFlowCoordinator(searchProvider: mockSearchProvider, beerProvider: mockBeerProvider)
        let result = sut.prepareTransition(for: .search)
        XCTAssertEqual(result.presentables.count, 1)
        let presentable = try! XCTUnwrap(result.presentables.first)
        XCTAssertTrue(presentable is SearchFlowCoordinator.SearchScreenCoordinator)
    }
    
    func test_SearchFlowCoordinator_prepareTransition_SHOULD_pushBeerDetailScreen_WITH_beerDetails_event() {
        let sut = SearchFlowCoordinator(searchProvider: mockSearchProvider, beerProvider: mockBeerProvider)
        let result = sut.prepareTransition(for: .beerDetails(id: "1"))
        XCTAssertEqual(result.presentables.count, 1)
        let presentable = try! XCTUnwrap(result.presentables.first)
        XCTAssertTrue(presentable is SearchFlowCoordinator.BeerScreenCoordinator)
    }
    
    func test_SearchFlowCoordinator_prepareTransition_SHOULD_addChild_WITH_search_event() {
        let sut = SearchFlowCoordinator(searchProvider: mockSearchProvider, beerProvider: mockBeerProvider)
        sut.trigger(.search)
        XCTAssertEqual(sut.children.count, 2)
        let child = try! XCTUnwrap(sut.children.last)
        XCTAssertTrue(child is SearchFlowCoordinator.SearchScreenCoordinator)
    }
    
    func test_SearchFlowCoordinator_prepareTransition_SHOULD_addChild_WITH_beerDetails_event() {
        let sut = SearchFlowCoordinator(searchProvider: mockSearchProvider, beerProvider: mockBeerProvider)
        sut.trigger(.beerDetails(id: "1"))
        XCTAssertEqual(sut.children.count, 2)
        let child = try! XCTUnwrap(sut.children.last)
        XCTAssertTrue(child is SearchFlowCoordinator.BeerScreenCoordinator)
    }
    
    // MARK: SearchFlowCoordinator.SearchScreenCoordinator
    
    func test_SearchScreenCoordinator_SHOULD_containTheSearchView() {
        let sut = SearchFlowCoordinator.SearchScreenCoordinator(parent: mockRouter.unownedRouter,
                                                                searchProvider: mockSearchProvider)
        XCTAssertTrue(sut.viewController is UIHostingController<SearchView>)
    }
    
    func test_SearchScreenCoordinator_mapToParent_SHOULD_mapCorrectly_beerIsPicked() {
        let sut = SearchFlowCoordinator.SearchScreenCoordinator(parent: mockRouter.unownedRouter,
                                                                searchProvider: mockSearchProvider)
        let id = "123"
        let result = sut.mapToParent(.beerIsPicked(id: id))
        XCTAssertEqual(result, .beerDetails(id: id))
    }
    
    // MARK: SearchFlowCoordinator.BeerScreenCoordinator
    
    func test_BeerScreenCoordinator_SHOULD_containTheBeerDetailView() {
        let sut = SearchFlowCoordinator.BeerScreenCoordinator(id: "123",
                                                              parent: mockRouter.unownedRouter,
                                                              beerProvider: mockBeerProvider)
        XCTAssertTrue(sut.viewController is UIHostingController<BeerDetailView>)
    }

}
