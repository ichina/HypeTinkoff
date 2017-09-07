//
//  News.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation

public struct NewsItem {
    public var id: String
    public var title: String?
    public var published: Int64
    
    public init(id: String, title: String?, published: Int64 = 0) {
        self.id = id
        self.title = title
        self.published = published
    }
}

extension NewsItem: Equatable {
    public static func == (lhs: NewsItem, rhs: NewsItem) -> Bool {
        return lhs.id == rhs.id
    }
}
