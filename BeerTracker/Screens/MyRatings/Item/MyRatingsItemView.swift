//
//  MyRatingsItemView.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/10/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI

struct MyRatingsItemView: View {
    
    @ObservedObject private var viewModel: MyRatingsItemViewModel
    
    init(viewModel: MyRatingsItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .center) {
            CircleImage(imageURL: viewModel.imageURL, diameter: 75)
            VStack(alignment: .leading) {
                Text(viewModel.nameText)
                    .font(.headline)
                Text(viewModel.breweryText)
                      .font(.subheadline)
                Text(viewModel.locationText)
                    .font(.subheadline)
                Text(viewModel.ratingText)
                    .font(.subheadline)
            }
            
        }
        .padding()
    }
}

//struct HomeCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeCellView(viewModel: HomeCellViewModel(id: UUID(),
//                                                  nameText: "Brewery Name",
//                                                  locationText: "Location String"),
//                     imageURL: URL(string: "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80")!)
//    }
//}
