//
//  SearchViewModelTests.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 11/16/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Combine
import XCTest
@testable import BeerTracker

class SearchViewModelTests: XCTestCase {
    
    private var disposeBag: Set<AnyCancellable>!
    private var mockSearchProvider: MockSearchProvider!
    
    override func setUp() {
        disposeBag = Set<AnyCancellable>()
        mockSearchProvider = MockSearchProvider()
    }
    
    override func tearDown() {
        disposeBag = nil
        mockSearchProvider = nil
    }
    
    // MARK: resultViewModels
    
    func test_resultViewModels_SHOULD_defaultToEmpty() {
        let sut = SearchViewModel(provider: mockSearchProvider,
                                  mainDispatchQueue: DispatchQueue.main,
                                  globalDispatchQueue: DispatchQueue.main)
        
        XCTAssertEqual(sut.resultViewModels.count, 0)
    }
    
    func test_resultViewModels_SHOULD_beEmpty_WHEN_networkError() {
        let expectation = self.expectation(description: #function)
        
        let sut = SearchViewModel(provider: mockSearchProvider,
                                  mainDispatchQueue: DispatchQueue.main,
                                  globalDispatchQueue: DispatchQueue.main)
        
        var elements: [[SearchResultViewModel]] = []
        
        sut.$resultViewModels
            .dropFirst()
            .sink(receiveValue: {
                elements.append($0)
                expectation.fulfill()
            })
            .store(in: &disposeBag)
        
        ["a", "ab", "abc", "abcd"]
            .publisher
            .assign(to: \.searchQuery, on: sut)
            .store(in: &disposeBag)
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(elements, [[]])
        }
    }
    
    func test_resultViewModels_SHOULD_beNonEmpty_WHEN_networkSuccess() {
        mockSearchProvider.searchResult = .success(SearchBeersQuery.Data.mockData)
        
        let expectation = self.expectation(description: #function)
        
        let sut = SearchViewModel(provider: mockSearchProvider,
                                  mainDispatchQueue: DispatchQueue.main,
                                  globalDispatchQueue: DispatchQueue.main)
        
        var elements: [[SearchResultViewModel]] = []
        
        sut.$resultViewModels
            .dropFirst()
            .sink(receiveValue: {
                elements.append($0)
                expectation.fulfill()
            })
            .store(in: &disposeBag)
        
        ["a", "ab", "abc", "abcd"]
            .publisher
            .assign(to: \.searchQuery, on: sut)
            .store(in: &disposeBag)
        
        waitForExpectations(timeout: 1) { _ in
            let resultViewModel = SearchResultViewModel(result: SearchBeersQuery.Data.mockData.searchBeers!.first!)
            
            XCTAssertEqual(elements, [[resultViewModel]])
        }
    }
    
    // MARK: SearchProvider
    
    func test_searchQuery_SHOULD_triggerNetworkCallOnce_WHEN_networkSuccess() {
        mockSearchProvider.searchResult = .success(SearchBeersQuery.Data.mockData)
        
        let expectation = self.expectation(description: #function)
        
        let sut = SearchViewModel(provider: mockSearchProvider,
                                  mainDispatchQueue: DispatchQueue.main,
                                  globalDispatchQueue: DispatchQueue.main)
        
        sut.$resultViewModels
            .dropFirst() // ignore the default value
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })
            .store(in: &disposeBag)
        
        // Simulate user typing into the query
        ["a", "ab", "abc", "abcd"]
            .publisher
            .assign(to: \.searchQuery, on: sut)
            .store(in: &disposeBag)
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.mockSearchProvider.searchCallCount, 1)
            XCTAssertEqual(self.mockSearchProvider.searchParamQuery.first, "abcd")
        }
    }
    
    func test_searchQuery_SHOULD_triggerNetworkCallOnce_WHEN_networkError() {
        let expectation = self.expectation(description: #function)
        
        let sut = SearchViewModel(provider: mockSearchProvider,
                                  mainDispatchQueue: DispatchQueue.main,
                                  globalDispatchQueue: DispatchQueue.main)
        
        sut.$resultViewModels
            .dropFirst() // ignore the default value
            .sink(receiveValue: { _ in
                expectation.fulfill()
            })
            .store(in: &disposeBag)
        
        // Simulate user typing into the query
        ["a", "ab", "abc", "abcd"]
            .publisher
            .assign(to: \.searchQuery, on: sut)
            .store(in: &disposeBag)
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(self.mockSearchProvider.searchCallCount, 1)
            XCTAssertEqual(self.mockSearchProvider.searchParamQuery.first, "abcd")
        }
    }
}

private extension SearchBeersQuery.Data {
    static let mockData: Self = {
        let brewery = SearchBeersQuery.Data.SearchBeer.Brewery(name: "breweryName")
        let beer = SearchBeersQuery.Data.SearchBeer(id: "id",
                                                    imageUrl: "http://www.image.com",
                                                    name: "beerName",
                                                    type: "IPA",
                                                    brewery: brewery)
        
        return Self(searchBeers: [beer])
    }()
}
