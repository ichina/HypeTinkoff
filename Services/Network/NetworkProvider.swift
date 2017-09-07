//
//  NetworkProvider.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import Model
class NetworkProvider {
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = "https://api.tinkoff.ru/v1"
    }
    
    public func makeNewsNetwork() -> NewsNetwork {
        let network = Network<NewsItem>(apiEndpoint)
        return NewsNetwork(network: network)
    }

}
