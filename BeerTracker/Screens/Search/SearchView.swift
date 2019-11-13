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
        VStack {
            TextField("Search...", text: $viewModel.searchQuery)
                .padding()
            
//            List(viewModel.resultViewModels) { model in
//                Text(model)
//            }
            
        }
    }
}

//struct Search_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
