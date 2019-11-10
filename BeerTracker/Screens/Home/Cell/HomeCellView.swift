//
//  HomeCellView.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/10/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI

struct HomeCellView: View {
    
    @ObservedObject private var viewModel: HomeCellViewModel
    
    init(viewModel: HomeCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.nameText)
            Text(viewModel.locationText)
        }
    }
}

//struct HomeCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeCellView(viewModel: HomeCellViewModel())
//    }
//}
//
//private extension HomeCellViewModel {
//    init() {
//        id = UUID()
//        nameText = "Test Name"
//        locationText = "Location"
//    }
//}
