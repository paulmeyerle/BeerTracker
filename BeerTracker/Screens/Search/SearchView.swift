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
            Group {
                TextField(viewModel.placeholderText, text: $viewModel.searchQuery)
                    .padding(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(UIColor.lightGray), lineWidth: 1)
                    )
                    .navigationBarTitle(viewModel.titleText)
            }
            .padding()

            Group {
                List(viewModel.resultViewModels) { model in
                    VStack(alignment: .leading) {
                        SearchResultView(viewModel: model)
                            .onTapGesture {
                                self.viewModel.onModelSelected(model)
                        }
                        
                        Divider()
                    }
                }
            }            
        }
        .modifier(DismissingKeyboard())
    }
}

//struct Search_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
