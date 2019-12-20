//
//  ScreenCoordinator.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 12/19/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import XCoordinator

protocol ScreenCoordinator: Router {
    associatedtype ParentRoute: Route
    var parent: UnownedRouter<ParentRoute> { get }
    
    func mapToParent(_ route: RouteType) -> ParentRoute?
}

extension ScreenCoordinator {
    func contextTrigger(_ route: RouteType, with options: TransitionOptions, completion: ContextPresentationHandler?) {
        guard let parentRoute = mapToParent(route) else { return }
        parent.contextTrigger(parentRoute, with: options, completion: completion)
    }
}

extension ScreenCoordinator where Self: Presentable & AnyObject  {
    var weakRouter: WeakRouter<RouteType> {
        return WeakRouter(self) { $0.strongRouter }
    }
    
    var unownedRouter: UnownedRouter<RouteType> {
        return UnownedRouter(self) { $0.strongRouter }
    }
}
