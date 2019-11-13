//
//  ContentView.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/9/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    // TODO: Need injection pattern for view models & service providers
    var body: some View {
        TabView {
            // List of rated beers
            MyRatingsView(viewModel: MyRatingsViewModel(provider: ApolloServiceProvider()))
                .tabItem { MyRatingsTabItem() }
            
            // Search for beers to rate.
            SearchView(viewModel: SearchViewModel(provider: ApolloServiceProvider()))
                .tabItem { SearchTabItem() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
