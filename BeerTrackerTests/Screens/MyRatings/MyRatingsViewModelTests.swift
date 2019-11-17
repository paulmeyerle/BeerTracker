//
//  MyRatingsViewModelTests.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 11/17/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import XCTest
@testable import BeerTracker

class MyRatingsViewModelTests: XCTestCase {

    private var disposeBag: Set<AnyCancellable>!
    private var mockProvider: MockMyRatingsProvider!

    override func setUp() {
        disposeBag = Set<AnyCancellable>()
        mockProvider = MockMyRatingsProvider()
    }

    override func tearDown() {
        disposeBag = nil
        mockProvider = nil
    }

    // MARK: isLoading
    
    func test_isLoading_SHOULD_defaultToFalse() {
        let sut = MyRatingsViewModel(provider: mockProvider)
        XCTAssertFalse(sut.isLoading)
    }
    
    func test_isLoading_SHOULD_toggleAfterFetch() {
        let sut = MyRatingsViewModel(provider: mockProvider)
        
        var elements: [Bool] = []
        
        sut.$isLoading
            .sink { elements.append($0) }
            .store(in: &disposeBag)
        
        sut.fetch()
        
        XCTAssertEqual(elements, [false, true, false])
    }
    
    // MARK: cellViewModels
    
    func test_cellViewModels_SHOULD_defaultToEmpty() {
        let sut = MyRatingsViewModel(provider: mockProvider)
        XCTAssertEqual(sut.cellViewModels.count, 0)
    }
    
    func test_cellViewModels_SHOULD_returnEmptyOnNetworkError() {
        let sut = MyRatingsViewModel(provider: mockProvider)

        var elements: [[MyRatingsItemViewModel]] = []
        
        sut.$cellViewModels
            .sink { elements.append($0) }
            .store(in: &disposeBag)
        
        sut.fetch()
        
        XCTAssertEqual(elements, [[],[]])
    }
    
    func test_cellViewModels_SHOULD_returnNonEmptyOnNetworkSuccess() {
        mockProvider.fetchMyRatingsResult = .success(MyRatingsQuery.Data.mockData)
        
        let sut = MyRatingsViewModel(provider: mockProvider)

        var elements: [[MyRatingsItemViewModel]] = []
        
        sut.$cellViewModels
            .sink { elements.append($0) }
            .store(in: &disposeBag)
        
        sut.fetch()
        
        let rating = MyRatingsQuery.Data.mockData.myRatings!.first!
        let expectation = [MyRatingsItemViewModel(rating: rating)]
        XCTAssertEqual(elements, [[], expectation])
    }
    
    // MARK: Service Provider
    
    func test_fetch_SHOULD_makeOneNetworkRequest() {
        let sut = MyRatingsViewModel(provider: mockProvider)
        sut.fetch()
        
        XCTAssertEqual(mockProvider.fetchMyRatingsCallCount, 1)
    }
}

private extension MyRatingsQuery.Data {
    static let mockData: Self = {
        let brewery = MyRatingsQuery.Data.MyRating.Beer.Brewery(name: "BreweryName", state: "State", county: "County")
        let beer = MyRatingsQuery.Data.MyRating.Beer(imageUrl: "http://image.com", name: "BeerName", brewery: brewery)
        let rating = MyRatingsQuery.Data.MyRating(id: "id", rating: 2, beer: beer)
        return Self(myRatings: [rating])
    }()
}
