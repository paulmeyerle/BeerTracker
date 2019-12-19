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
            let screen = MyRatingsScreenCoordinator(parent: unownedRouter, myRatingsProvider: myRatingsProvider)
            return .push(screen)
        case .ratingDetail(let id):
            let screen = RatingScreenCoordinator(id: id, parent: unownedRouter)
            return .push(screen)
        }
    }
    
    final class MyRatingsScreenCoordinator: ScreenCoordinator {
        typealias ParentRoute = HomeFlowCoordinatorRoute
        typealias RouteType = MyRatingsViewEvent
        
        let parent: UnownedRouter<HomeFlowCoordinatorRoute>
        private let myRatingsProvider: MyRatingsProvider
        
        lazy var viewController: UIViewController! = {
            let viewModel = MyRatingsViewModel(provider: myRatingsProvider, router: unownedRouter)
            let view = MyRatingsView(viewModel: viewModel)
            return UIHostingController(rootView: view)
        }()
        
        init(parent: UnownedRouter<HomeFlowCoordinatorRoute>, myRatingsProvider: MyRatingsProvider) {
            self.parent = parent
            self.myRatingsProvider = myRatingsProvider
        }
        
        func mapToParent(_ route: MyRatingsViewEvent) -> HomeFlowCoordinatorRoute? {
            switch route {
              case .ratingIsPicked(let id):
                  return .ratingDetail(id: id)
              }
        }
    }
    
    final class RatingScreenCoordinator: ScreenCoordinator {
        typealias ParentRoute = HomeFlowCoordinatorRoute
        typealias RouteType = RatingDetailViewEvent
        
        private let id: String
        let parent: UnownedRouter<HomeFlowCoordinatorRoute>
        
        lazy var viewController: UIViewController! = {
            let view = RatingDetailView()
            return UIHostingController(rootView: view)
        }()
        
        init(id: String, parent: UnownedRouter<HomeFlowCoordinatorRoute>) {
            self.id = id
            self.parent = parent
        }
        
        func mapToParent(_ route: RatingDetailViewEvent) -> HomeFlowCoordinatorRoute? {
            return nil
        }
    }
}
