//
//  HomeFlowCoordinator.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 12/16/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI
import XCoordinator

final class HomeFlowCoordinator: NavigationCoordinator<HomeFlowCoordinatorEvent> {
    
    private let myRatingsProvider: MyRatingsProvider
    
    init(myRatingsProvider: MyRatingsProvider) {
        self.myRatingsProvider = myRatingsProvider
        super.init(initialRoute: .myRatings)
    }
    
    override func prepareTransition(for route: RouteType) -> NavigationTransition {
        switch route {
        case .myRatings:
            let coordinator = MyRatingsScreenCoordinator(rootViewController: rootViewController,
                                                         myRatingsProvider: myRatingsProvider,
                                                         parent: unownedRouter)
            addChild(coordinator)
            return .trigger(.started, on: coordinator)
        case .ratingIsPicked:
            let child = BeerScreenCoordinator(rootViewController: rootViewController,
                                              parent: unownedRouter)
            addChild(child)
            return .trigger(.started(id: "fake id"), on: child)
        }
    }
    
    final class MyRatingsScreenCoordinator: NavigationCoordinator<MyRatingsViewEvent> {
        
        private let myRatingsProvider: MyRatingsProvider
        private let parent: UnownedRouter<HomeFlowCoordinatorEvent>
        
        init(rootViewController: RootViewController,
             myRatingsProvider: MyRatingsProvider,
             parent: UnownedRouter<HomeFlowCoordinatorEvent>) {
            self.myRatingsProvider = myRatingsProvider
            self.parent = parent
            super.init(rootViewController: rootViewController)
        }
        
        override func prepareTransition(for route: RouteType) -> NavigationTransition {
            switch route {
            case .started:
                let viewModel = MyRatingsViewModel(provider: myRatingsProvider,
                                                   router: unownedRouter)
                let view = MyRatingsView(viewModel: viewModel)
                let controller = UIHostingController(rootView: view)
                return .push(controller)
            case .ratingSelected:
                return .trigger(.ratingIsPicked, on: parent)
            }
        }
    }
    
    // TODO: Replace with Rating View
    final class BeerScreenCoordinator: NavigationCoordinator<BeerViewEvent> {
        
        //        private let beerProvider: BeerProvider
        private let parent: UnownedRouter<HomeFlowCoordinatorEvent>
        
        init(rootViewController: RootViewController,
             //             beerProvider: BeerProvider,
            parent: UnownedRouter<HomeFlowCoordinatorEvent>) {
            //            self.beerProvider = beerProvider
            self.parent = parent
            super.init(rootViewController: rootViewController)
        }
        
        override func prepareTransition(for route: RouteType) -> NavigationTransition {
            switch route {
            case .started(let id):
                let view = BeerView()
                let controller = UIHostingController(rootView: view)
                return .push(controller)
            }
        }
    }
}
