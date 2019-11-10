//
//  HomeTabItem.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/9/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SwiftUI

struct HomeTabItem: View {
    var body: some View {
        VStack {
            Image(systemName: "arkit")
            Text("Home")
        }
    }
}

struct HomeTabItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabItem()
    }
}
