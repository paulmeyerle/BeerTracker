//
//  SearchFlowCoordinator.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 12/16/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI
import XCoordinator

final class SearchFlowCoordinator: NavigationCoordinator<SearchFlowCoordinatorEvent> {
    private let searchProvider: SearchProvider
    
    init(searchProvider: SearchProvider) {
        self.searchProvider = searchProvider
        super.init(initialRoute: .search)
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
                                              parent: unownedRouter)
            addChild(child)
            return .trigger(.started(id: id), on: child)
        }
    }
    
    final class SearchScreenCoordinator: NavigationCoordinator<SearchViewEvent> {
        
        private let searchProvider: SearchProvider
        private let parent: UnownedRouter<SearchFlowCoordinatorEvent>
        
        init(rootViewController: RootViewController,
             searchProvider: SearchProvider,
             parent: UnownedRouter<SearchFlowCoordinatorEvent>) {
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
    
    final class BeerScreenCoordinator: NavigationCoordinator<BeerViewEvent> {
        
//        private let beerProvider: BeerProvider
        private let parent: UnownedRouter<SearchFlowCoordinatorEvent>
        
        init(rootViewController: RootViewController,
//             beerProvider: BeerProvider,
             parent: UnownedRouter<SearchFlowCoordinatorEvent>) {
//            self.beerProvider = beerProvider
            self.parent = parent
            super.init(rootViewController: rootViewController)
        }
        
        override func prepareTransition(for route: RouteType) -> NavigationTransition {
            switch route {
            case .started(let id):
//                let viewModel = BeerViewModel(beerId: id,
//                                              provider: beerProvider,
//                                              router: unownedRouter)
//                let view = BeerView(viewModel: viewModel)
                let view = BeerView()
                let controller = UIHostingController(rootView: view)
                return .push(controller)
            }
        }
    }
}
