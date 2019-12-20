//
//  HomeFlowCoordinatorTests.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 12/19/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI
import XCTest
@testable import BeerTracker

class HomeFlowCoordinatorTests: XCTestCase {
    
    private var mockRouter: MockRouter<HomeFlowCoordinatorRoute>!
    private var mockProvider: MockMyRatingsProvider!

    override func setUp() {
        mockRouter = MockRouter<HomeFlowCoordinatorRoute>()
        mockProvider = MockMyRatingsProvider()
    }

    override func tearDown() {
        mockRouter = nil
        mockProvider = nil
    }

    // MARK: HomeFlowCoordinator
    
    func test_HomeFlowCoordinator_SHOULD_defaultToMyRatings() {
        let sut = HomeFlowCoordinator(myRatingsProvider: mockProvider)
        XCTAssertEqual(sut.children.count, 1)
        let child = try! XCTUnwrap(sut.children.first)
        XCTAssertTrue(child is HomeFlowCoordinator.MyRatingsScreenCoordinator)
    }
    
    func test_HomeFlowCoordinator_prepareTransition_SHOULD_pushMyRatingsScreen_WITH_myRatings_event() {
        let sut = HomeFlowCoordinator(myRatingsProvider: mockProvider)
        let result = sut.prepareTransition(for: .myRatings)
        XCTAssertEqual(result.presentables.count, 1)
        let presentable = try! XCTUnwrap(result.presentables.first)
        XCTAssertTrue(presentable is HomeFlowCoordinator.MyRatingsScreenCoordinator)
    }
    
    func test_HomeFlowCoordinator_prepareTransition_SHOULD_pushRatingDetailScreen_WITH_ratingDetail_event() {
        let sut = HomeFlowCoordinator(myRatingsProvider: mockProvider)
        let result = sut.prepareTransition(for: .ratingDetail(id: "1"))
        XCTAssertEqual(result.presentables.count, 1)
        let presentable = try! XCTUnwrap(result.presentables.first)
        XCTAssertTrue(presentable is HomeFlowCoordinator.RatingScreenCoordinator)
    }
    
    func test_HomeFlowCoordinator_prepareTransition_SHOULD_addChild_WITH_myRatings_event() {
        let sut = HomeFlowCoordinator(myRatingsProvider: mockProvider)
        sut.trigger(.myRatings)
        XCTAssertEqual(sut.children.count, 2)
        let child = try! XCTUnwrap(sut.children.last)
        XCTAssertTrue(child is HomeFlowCoordinator.MyRatingsScreenCoordinator)
    }
    
    func test_HomeFlowCoordinator_prepareTransition_SHOULD_addChild_WITH_ratingDetail_event() {
        let sut = HomeFlowCoordinator(myRatingsProvider: mockProvider)
        sut.trigger(.ratingDetail(id: "1"))
        XCTAssertEqual(sut.children.count, 2)
        let child = try! XCTUnwrap(sut.children.last)
        XCTAssertTrue(child is HomeFlowCoordinator.RatingScreenCoordinator)
    }
    
    // MARK: HomeFlowCoordinator.MyRatingsScreenCoordinator
    
    func test_MyRatingsScreenCoordinator_SHOULD_containTheMyRatingsView() {
        let sut = HomeFlowCoordinator.MyRatingsScreenCoordinator(parent: mockRouter.unownedRouter,
                                                                 myRatingsProvider: mockProvider)
        XCTAssertTrue(sut.viewController is UIHostingController<MyRatingsView>)
    }
    
    func test_MyRatingsScreenCoordinator_mapToParent_SHOULD_mapCorrectly_ratingIsPicked() {
        let sut = HomeFlowCoordinator.MyRatingsScreenCoordinator(parent: mockRouter.unownedRouter,
                                                                 myRatingsProvider: mockProvider)
        let id = "123"
        let result = sut.mapToParent(.ratingIsPicked(id: id))
        XCTAssertEqual(result, .ratingDetail(id: id))
    }
    
    // MARK: HomeFlowCoordinator.RatingScreenCoordinator
    
    func test_RatingScreenCoordinator_SHOULD_containTheRatingDetailView() {
        let sut = HomeFlowCoordinator.RatingScreenCoordinator(id: "123",
                                                              parent: mockRouter.unownedRouter)
        XCTAssertTrue(sut.viewController is UIHostingController<RatingDetailView>)
    }
    
}
