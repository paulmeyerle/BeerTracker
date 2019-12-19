//
//  TabCoordinator.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 12/16/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import XCoordinator

final class TabCoordinator: TabBarCoordinator<TabCoordinatorRoute> {
    private let homeRouter: StrongRouter<HomeFlowCoordinatorRoute>
    private let searchRouter: StrongRouter<SearchFlowCoordinatorRoute>
    
    convenience init(myRatingsProvider: MyRatingsProvider,
                     searchProvider: SearchProvider,
                     beerProvider: BeerProvider) {
        let homeCoordinator = HomeFlowCoordinator(myRatingsProvider: myRatingsProvider)
        homeCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "My Ratings", image: nil, tag: 0)

        let searchCoordinator = SearchFlowCoordinator(searchProvider: searchProvider,
                                                      beerProvider: beerProvider)
        searchCoordinator.rootViewController.tabBarItem = UITabBarItem(title: "Search", image: nil, tag: 0)

        self.init(myRatingsRouter: homeCoordinator.strongRouter,
                  searchRouter: searchCoordinator.strongRouter)
    }

    init(myRatingsRouter: StrongRouter<HomeFlowCoordinatorRoute>,
         searchRouter: StrongRouter<SearchFlowCoordinatorRoute>) {
        self.homeRouter = myRatingsRouter
        self.searchRouter = searchRouter

        super.init(tabs: [myRatingsRouter, searchRouter], select: myRatingsRouter)
        
        rootViewController.modalPresentationStyle = .fullScreen
    }
    
    override func prepareTransition(for route: RouteType) -> TabBarTransition {
        switch route {
        case .myRatings:
            return .select(homeRouter)
        case .search:
            return .select(searchRouter)
        }
    }
}
