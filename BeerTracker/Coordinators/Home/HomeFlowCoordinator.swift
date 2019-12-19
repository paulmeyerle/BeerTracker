//
//  HomeFlowCoordinator.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 12/16/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI
import XCoordinator

final class HomeFlowCoordinator: NavigationCoordinator<HomeFlowCoordinatorRoute> {
    
    private let myRatingsProvider: MyRatingsProvider
    
    init(myRatingsProvider: MyRatingsProvider) {
        self.myRatingsProvider = myRatingsProvider
        super.init(initialRoute: .myRatings)
        
        rootViewController.navigationBar.prefersLargeTitles = true
    }
    
    override func prepareTransition(for route: RouteType) -> NavigationTransition {
        switch route {
        case .myRatings:
            let coordinator = MyRatingsScreenCoordinator(rootViewController: rootViewController,
                                                         myRatingsProvider: myRatingsProvider,
                                                         parent: unownedRouter)
            addChild(coordinator)
            return .trigger(.started, on: coordinator)
        case .ratingDetail(let id):
            let child = RatingScreenCoordinator(rootViewController: rootViewController,
                                              parent: unownedRouter)
            addChild(child)
            return .trigger(.started(id: id), on: child)
        }
    }
    
    final class MyRatingsScreenCoordinator: NavigationCoordinator<MyRatingsViewEvent> {
        
        private let myRatingsProvider: MyRatingsProvider
        private let parent: UnownedRouter<HomeFlowCoordinatorRoute>
        
        init(rootViewController: RootViewController,
             myRatingsProvider: MyRatingsProvider,
             parent: UnownedRouter<HomeFlowCoordinatorRoute>) {
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
            case .ratingIsPicked(let id):
                return .trigger(.ratingDetail(id: id), on: parent)
            }
        }
    }
    
    final class RatingScreenCoordinator: NavigationCoordinator<RatingDetailViewEvent> {
        private let parent: UnownedRouter<HomeFlowCoordinatorRoute>
        
        init(rootViewController: RootViewController,
            parent: UnownedRouter<HomeFlowCoordinatorRoute>) {
            self.parent = parent
            super.init(rootViewController: rootViewController)
        }
        
        override func prepareTransition(for route: RouteType) -> NavigationTransition {
            switch route {
            case .started(let id):
                print("id: \(id)")
                let view = RatingDetailView()
                let controller = UIHostingController(rootView: view)
                return .push(controller)
            }
        }
    }
}
