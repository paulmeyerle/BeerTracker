//
//  MyRatingsView.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/9/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI
import Combine

struct MyRatingsView: View {
    
    @ObservedObject private var viewModel: MyRatingsViewModel
    
    init(viewModel: MyRatingsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) { cellViewModel in
            VStack(alignment: .leading) {
                MyRatingsItemView(viewModel: cellViewModel)
                    .onTapGesture {
                        self.viewModel.onModelSelected(cellViewModel)
                    }
                
                Divider()
            }
        }
        .onAppear {
            self.viewModel.fetch()
        }
        .navigationBarTitle(viewModel.titleText)
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        let provider = ApolloServiceProvider()
//        let viewModel = MyRatingsViewModel(provider: provider)
//        return MyRatingsView(viewModel: viewModel)
//    }
//}
