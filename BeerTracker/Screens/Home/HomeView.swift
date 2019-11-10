//
//  HomeView.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/9/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @ObservedObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { cellViewModel in
            HomeCellView(viewModel: cellViewModel)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        let provider = ApolloServiceProvider()
        let viewModel = HomeViewModel(homeProvider: provider)
        return HomeView(viewModel: viewModel)
    }
}
