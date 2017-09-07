//
//  NewsNetwork.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import RxSwift
import Model
class NewsNetwork {
    private let network: Network<NewsItem>
    private let pageSize = 20
    init(network: Network<NewsItem>) {
        self.network = network
    }
    
    public func fetchNews(page: Int) -> Observable<[NewsItem]> {
        return network.getItems("news", params:[
            "first" : String(page*pageSize),
            "last" : String((page+1)*pageSize)
            ])
    }

}
