//
//  CircleImage.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 12/19/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import SDWebImageSwiftUI
import SwiftUI

struct CircleImage: View {
    
    private let imageURL: URL?
    private let diameter: CGFloat
    
    init(imageURL: URL?, diameter: CGFloat) {
        self.imageURL = imageURL
        self.diameter = diameter
    }
    
    var body: some View {
        WebImage(url: imageURL)
            .placeholder {
                ZStack {
                    Rectangle()
                        .fill(Color(.lightGray))
                    ActivityIndicator(.constant(true), style: .medium)
                }
            }
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .clipShape(Circle())
            .shadow(radius: 5)
            .overlay(Circle().stroke(Color(.lightGray), lineWidth: 1))
            .frame(width: diameter, height: diameter)
    }
}
