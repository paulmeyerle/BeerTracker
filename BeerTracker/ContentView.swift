//
//  ContentView.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/9/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel(homeProvider: ApolloServiceProvider()))
                .tabItem { HomeTabItem() }
            
            Search()
                .tabItem { SearchTabItem() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
