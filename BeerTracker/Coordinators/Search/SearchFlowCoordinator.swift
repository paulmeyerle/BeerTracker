//
//  SearchFlowCoordinator.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 12/16/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI
import XCoordinator

final class SearchFlowCoordinator: NavigationCoordinator<SearchFlowCoordinatorRoute> {
    private let searchProvider: SearchProvider
    private let beerProvider: BeerProvider
    
    init(searchProvider: SearchProvider, beerProvider: BeerProvider) {
        self.searchProvider = searchProvider
        self.beerProvider = beerProvider
        super.init(initialRoute: .search)
        
        rootViewController.navigationBar.prefersLargeTitles = true
    }
    
    override func prepareTransition(for route: RouteType) -> NavigationTransition {
        switch route {
        case .search:
            let screen = SearchScreenCoordinator(parent: unownedRouter,
                                                 searchProvider: searchProvider)
            return .push(screen)
        case .beerDetails(let id):
            let screen = BeerScreenCoordinator(id: id,
                                               parent: unownedRouter,
                                               beerProvider: beerProvider)
            return .push(screen)
        }
    }
    
    final class SearchScreenCoordinator: ScreenCoordinator {
        typealias RouteType = SearchViewEvent
        typealias ParentRoute = SearchFlowCoordinatorRoute
        
        let parent: UnownedRouter<SearchFlowCoordinatorRoute>
        let searchProvider: SearchProvider
        
        lazy var viewController: UIViewController! = {
            let viewModel = SearchViewModel(provider: searchProvider, router: unownedRouter)
            let view = SearchView(viewModel: viewModel)
            return UIHostingController(rootView: view)
        }()
        
        init(parent: UnownedRouter<SearchFlowCoordinatorRoute>,
             searchProvider: SearchProvider) {

            self.parent = parent
            self.searchProvider = searchProvider
        }
        
        func mapToParent(_ route: SearchViewEvent) -> SearchFlowCoordinatorRoute? {
            switch route {
            case .beerIsPicked(let id):
                return .beerDetails(id: id)
            }
        }
    }

    final class BeerScreenCoordinator: ScreenCoordinator {
        typealias ParentRoute = SearchFlowCoordinatorRoute
        typealias RouteType = BeerDetailViewEvent
        
        private let id: String
        private let beerProvider: BeerProvider
        let parent: UnownedRouter<SearchFlowCoordinatorRoute>
        
        lazy var viewController: UIViewController! = {
            let viewModel = BeerDetailViewModel(id: id,
                                                provider: beerProvider,
                                                router: unownedRouter)
            let view = BeerDetailView(viewModel: viewModel)
            return UIHostingController(rootView: view)
        }()
        
        init(id: String,
             parent: UnownedRouter<SearchFlowCoordinatorRoute>,
             beerProvider: BeerProvider) {
            
            self.id = id
            self.parent = parent
            self.beerProvider = beerProvider
        }
        
        func mapToParent(_ route: BeerDetailViewEvent) -> SearchFlowCoordinatorRoute? {
            return nil
        }
    }
}
