//
//  ScreenCoordinatorTests.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 12/20/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import XCTest
import XCoordinator
@testable import BeerTracker

class ScreenCoordinatorTests: XCTestCase {
    
    enum FlowRoute: Route, Equatable {
        case search
        case beerDetails(id: Int)
    }
    
    enum ScreenEvent: Route, Equatable {
        case beerPicked(id: Int)
        case returnNil
    }
    
    final class TestScreenCoordinator: ScreenCoordinator {
        typealias ParentRoute = FlowRoute
        typealias RouteType = ScreenEvent
        
        var viewController: UIViewController! = MockViewController()
        var parent: UnownedRouter<FlowRoute>
        
        init(parent: UnownedRouter<FlowRoute>) {
            self.parent = parent
        }
        
        func mapToParent(_ route: ScreenEvent) -> FlowRoute? {
            switch route {
            case .beerPicked(let id):
                return .beerDetails(id: id)
            case .returnNil:
                return nil
            }
        }
    }
    
    var mockParentRouter: MockRouter<FlowRoute>!

    override func setUp() {
        mockParentRouter = MockRouter<FlowRoute>()
    }

    override func tearDown() {
        mockParentRouter = nil
    }

    // MARK: contextTrigger
    
    func test_contextTrigger_SHOULD_callParentRouter_WITH_mappedEvent() {
        let sut = TestScreenCoordinator(parent: mockParentRouter.unownedRouter)
        sut.trigger(.beerPicked(id: 1))
        XCTAssertEqual(mockParentRouter.contextTriggerCallCount, 1)
        XCTAssertEqual(mockParentRouter.contextTriggerParamRoute, [.beerDetails(id: 1)])
    }
    
    func test_contextTrigger_SHOULD_not_callParentRouter_WHEN_nilIsReturned() {
        let sut = TestScreenCoordinator(parent: mockParentRouter.unownedRouter)
        sut.trigger(.returnNil)
        XCTAssertEqual(mockParentRouter.contextTriggerCallCount, 0)
    }

}
