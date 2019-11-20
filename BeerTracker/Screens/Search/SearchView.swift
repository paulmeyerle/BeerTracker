//
//  SearchView.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/9/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchQuery)
                    .padding()
                
                List(viewModel.resultViewModels) { model in
                    // TODO: Research coordinator pattern for navigation
                    NavigationLink(destination: BeerView()) {
                        SearchResultView(viewModel: model)
                    }
                }
            }
        }
    }
}

//struct Search_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
