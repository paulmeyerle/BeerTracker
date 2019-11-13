//
//  ApolloClient+Combine.swift
//  BeerTracker
//
//  Created by Paul Meyerle on 11/12/19.
//  Copyright © 2019 Paul Meyerle. All rights reserved.
//

import Apollo
import Combine

extension ApolloClient {
    func fetch<Query: GraphQLQuery>(query: Query,
                                    cachePolicy: CachePolicy = .returnCacheDataElseFetch,
                                    context: UnsafeMutableRawPointer? = nil,
                                    queue: DispatchQueue = DispatchQueue.main) -> AnyPublisher<Query.Data, Error> {
        
        return ApolloPublisher<Query.Data> { [weak self] subscriber in
            let cancellable = self?.fetch(query: query, cachePolicy: cachePolicy, context: context, queue: queue) { (result) in
                switch result {
                case let .success(data):
                    if let underlyingData = data.data {
                        _ = subscriber.receive(underlyingData)
                    }
                    subscriber.receive(completion: .finished)
                case let .failure(error):
                    subscriber.receive(completion: .failure(error))
                }
            }
            
            return CancelBox(cancellable: cancellable)
        }
        .eraseToAnyPublisher()
    }
}

private final class CancelBox: Combine.Cancellable {
    private let cancellable: Apollo.Cancellable?
    
    init(cancellable: Apollo.Cancellable?) {
        self.cancellable = cancellable
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}

private final class ApolloPublisher<Output>: Publisher {
    typealias Failure = Error
    
    private let callback: (AnySubscriber<Output, Failure>) -> Combine.Cancellable?

    init(callback: @escaping (AnySubscriber<Output, Failure>) -> Combine.Cancellable?) {
        self.callback = callback
    }

    internal func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = Subscription(subscriber: AnySubscriber(subscriber), callback: callback)
        subscriber.receive(subscription: subscription)
    }
    
    private class Subscription: Combine.Subscription {
        private let cancellable: Combine.Cancellable?

        init(subscriber: AnySubscriber<Output, Failure>, callback: @escaping (AnySubscriber<Output, Failure>) -> Combine.Cancellable?) {
            self.cancellable = callback(subscriber)
        }

        func request(_ demand: Subscribers.Demand) {
            // We don't care for the demand right now
        }

        func cancel() {
            cancellable?.cancel()
        }
    }
}
