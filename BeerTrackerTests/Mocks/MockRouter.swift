//
//  MockRouter.swift
//  BeerTrackerTests
//
//  Created by Paul Meyerle on 12/19/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import UIKit.UIViewController
import XCoordinator

final class MockRouter<T: Route>: Router {
    var viewController: UIViewController!
    
    init(viewController: UIViewController = MockViewController()) {
        self.viewController = viewController
    }
    
    private(set) var contextTriggerCallCount: Int = 0
    private(set) var contextTriggerParamRoute = [T]()
    private(set) var contextTriggerParamOptions = [TransitionOptions]()
    func contextTrigger(_ route: T, with options: TransitionOptions, completion: ContextPresentationHandler?) {
        contextTriggerCallCount += 1
        contextTriggerParamRoute.append(route)
        contextTriggerParamOptions.append(options)
    }
    
    public var unownedRouter: UnownedRouter<RouteType> {
        return UnownedRouter(self) { $0.strongRouter }
    }
}
