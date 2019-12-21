//
//  TabCoordinatorTests.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 12/20/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import XCTest
@testable import BeerTracker

class TabCoordinatorTests: XCTestCase {

    private var sut: TabCoordinator!
    private var mockHomeRouter: MockRouter<HomeFlowCoordinatorRoute>!
    private var mockSearchRouter: MockRouter<SearchFlowCoordinatorRoute>!

    override func setUp() {
        mockHomeRouter = MockRouter<HomeFlowCoordinatorRoute>()
        mockSearchRouter = MockRouter<SearchFlowCoordinatorRoute>()
        
        sut = TabCoordinator(myRatingsRouter: mockHomeRouter.strongRouter,
                             searchRouter: mockSearchRouter.strongRouter)

    }

    override func tearDown() {
        sut = nil
        mockHomeRouter = nil
        mockSearchRouter = nil
    }

    
    // MARK: init
    
    func test_init_SHOULD_setModalPresentationStyle() {
        XCTAssertEqual(sut.rootViewController.modalPresentationStyle, .fullScreen)
    }
    
    func test_init_SHOULD_addTwoTabs() {
        XCTAssertEqual(sut.rootViewController.viewControllers?.count, 2)
    }
    
    func test_init_SHOULD_selectFirstTab() {
        XCTAssertEqual(sut.rootViewController.selectedIndex, 0)
    }
    
    // MARK: prepareTransition
    
    func test_prepareTransition_SHOULD_selectHome_WITH_myRatings_event() {
        let result = sut.prepareTransition(for: .myRatings)
        
        XCTAssertEqual(result.presentables.count, 1)
        let presentable = try! XCTUnwrap(result.presentables.first)
        
        XCTAssertEqual(String(describing: presentable), String(describing: mockHomeRouter.strongRouter))
    }
    
    func test_prepareTransition_SHOULD_selectSearch_WITH_search_event() {
        let result = sut.prepareTransition(for: .search)
        
        XCTAssertEqual(result.presentables.count, 1)
        let presentable = try! XCTUnwrap(result.presentables.first)
        
        XCTAssertEqual(String(describing: presentable), String(describing: mockSearchRouter.strongRouter))
    }
}
