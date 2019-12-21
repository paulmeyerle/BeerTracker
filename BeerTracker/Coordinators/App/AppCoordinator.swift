//
//  AppCoordinator.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 12/16/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import XCoordinator

final class AppCoordinator: ViewCoordinator<AppCoordinatorRoute> {
    
    private let myRatingsProvider: MyRatingsProvider
    private let searchProvider: SearchProvider
    private let beerProvider: BeerProvider
    
    private let presenter: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        return viewController
    }()
    
    init(myRatingsProvider: MyRatingsProvider,
         searchProvider: SearchProvider,
         beerProvider: BeerProvider) {
        self.myRatingsProvider = myRatingsProvider
        self.searchProvider = searchProvider
        self.beerProvider = beerProvider
        super.init(rootViewController: presenter, initialRoute: .home)
        
        // Disable separators on all tableviews
        UITableView.appearance().separatorStyle = .none
    }
    
    override func prepareTransition(for route: RouteType) -> TransitionType {
        switch route {
        case .home:
            let home = TabCoordinator(myRatingsProvider: myRatingsProvider, searchProvider: searchProvider, beerProvider: beerProvider)
            return .present(home)
        }
    }
}
