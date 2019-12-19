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
            let child = SearchScreenCoordinator(rootViewController: rootViewController,
                                                searchProvider: searchProvider,
                                                parent: unownedRouter)
            addChild(child)
            return .trigger(.started, on: child)
        case .beerDetails(let id):
            let child = BeerScreenCoordinator(rootViewController: rootViewController,
                                              beerProvider: beerProvider,
                                              parent: unownedRouter)
            addChild(child)
            return .trigger(.started(id: id), on: child)
        }
    }
    
    final class SearchScreenCoordinator: NavigationCoordinator<SearchViewEvent> {
        
        private let searchProvider: SearchProvider
        private let parent: UnownedRouter<SearchFlowCoordinatorRoute>
        
        init(rootViewController: RootViewController,
             searchProvider: SearchProvider,
             parent: UnownedRouter<SearchFlowCoordinatorRoute>) {
            self.searchProvider = searchProvider
            self.parent = parent
            super.init(rootViewController: rootViewController)
        }
        
        override func prepareTransition(for route: RouteType) -> NavigationTransition {
            switch route {
            case .started:
                let viewModel = SearchViewModel(provider: searchProvider,
                                                router: unownedRouter)
                let view = SearchView(viewModel: viewModel)
                let controller = UIHostingController(rootView: view)
                return .push(controller)
            case .beerIsPicked(let id):
                return .trigger(.beerDetails(id: id), on: parent)
            }
        }
    }
    
    final class BeerScreenCoordinator: NavigationCoordinator<BeerDetailViewEvent> {
        
        private let beerProvider: BeerProvider
        private let parent: UnownedRouter<SearchFlowCoordinatorRoute>
        
        init(rootViewController: RootViewController,
             beerProvider: BeerProvider,
             parent: UnownedRouter<SearchFlowCoordinatorRoute>) {
            self.beerProvider = beerProvider
            self.parent = parent
            super.init(rootViewController: rootViewController)
        }
        
        override func prepareTransition(for route: RouteType) -> NavigationTransition {
            switch route {
            case .started(let id):
                let viewModel = BeerDetailViewModel(id: id,
                                                    provider: beerProvider,
                                                    router: unownedRouter)
                let view = BeerDetailView(viewModel: viewModel)
                let controller = UIHostingController(rootView: view)
                return .push(controller)
            }
        }
    }
}
