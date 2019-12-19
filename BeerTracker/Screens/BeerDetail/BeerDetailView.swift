//
//  BeerDetailView.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/20/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI

struct BeerDetailView: View {
    
   @ObservedObject private var viewModel: BeerDetailViewModel
   
   init(viewModel: BeerDetailViewModel) {
       self.viewModel = viewModel
   }
    
    var body: some View {
        VStack {
            CircleImage(imageURL: viewModel.imageURL, diameter: 150)
            Text(viewModel.nameText)
            Text(viewModel.beerStyleText)
            Text(viewModel.breweryNameText)
        }.onAppear {
            self.viewModel.fetch()
        }
        .navigationBarTitle(viewModel.nameText)
    }
}

//struct BeerView_Previews: PreviewProvider {
//    static var previews: some View {
//        BeerDetailView()
//    }
//}
