//
//  Service.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/9/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Apollo
import Combine
import Foundation

final class ApolloServiceProvider {
    internal let client: ApolloClient
    
    init(client: ApolloClient = ApolloClient(url: URL(string: "http://localhost:9002/graphql")!)) {
        self.client = client
    }
}
