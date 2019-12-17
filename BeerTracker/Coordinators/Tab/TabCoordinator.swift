//
//  TabCoordinator.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 12/16/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import XCoordinator

final class TabCoordinator: TabBarCoordinator<TabCoordinatorEvent> {
    private let homeRouter: StrongRouter<HomeFlowCoordinatorEvent>
    private let searchRouter: StrongRouter<SearchFlowCoordinatorEvent>
    
    convenience init(myRatingsProvider: MyRatingsProvider, searchProvider: SearchProvider) {
        let homeCoordinator = HomeFlowCoordinator(myRatingsProvider: myRatingsProvider)
        homeCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)

        let searchCoordinator = SearchFlowCoordinator(searchProvider: searchProvider)
        searchCoordinator.rootViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        self.init(myRatingsRouter: homeCoordinator.strongRouter,
                  searchRouter: searchCoordinator.strongRouter)
    }

    init(myRatingsRouter: StrongRouter<HomeFlowCoordinatorEvent>,
         searchRouter: StrongRouter<SearchFlowCoordinatorEvent>) {
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
