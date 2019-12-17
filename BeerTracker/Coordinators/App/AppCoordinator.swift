//
//  AppCoordinator.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 12/16/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import XCoordinator

final class AppCoordinator: ViewCoordinator<AppCoordinatorEvent> {
    
    // TODO: inject
    private let provider = ApolloServiceProvider()
    
    private let presenter: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        return viewController
    }()
    
    init() {
        super.init(rootViewController: presenter, initialRoute: .home)
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .home:
            let home = TabCoordinator(myRatingsProvider: provider, searchProvider: provider)
            return .present(home)
        }
    }
}
