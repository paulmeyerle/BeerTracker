//
//  SearchTabItem.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/9/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI

struct SearchTabItem: View {
    var body: some View {
        VStack {
            Image(systemName: "icloud.fill")
            Text("Search")
        }
    }
}

struct SearchTabItem_Previews: PreviewProvider {
    static var previews: some View {
        SearchTabItem()
    }
}
