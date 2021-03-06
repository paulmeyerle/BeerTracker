//
//  SearchResultView.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/14/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI

struct SearchResultView: View {
    
    @ObservedObject private var viewModel: SearchResultViewModel
    
    init(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            CircleImage(imageURL: viewModel.imageURL, diameter: 50)

            VStack(alignment: .leading) {
                Text(viewModel.nameText)
                    .font(.headline)
                Text(viewModel.breweryNameText)
                      .font(.subheadline)
                Text(viewModel.beerStyleText)
                    .font(.subheadline)
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(viewModel: SearchResultViewModel(id: "id",
                                                          imageURL: URL(string: "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80")!,
                                                          nameText: "60 Minute IPA",
                                                          beerStyleText: "IPA",
                                                          breweryNameText: "Dodfish Head"))
    }
}
