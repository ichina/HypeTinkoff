//
//  NewsItem+Mapping.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import Model
import ObjectMapper

extension NewsItem: ImmutableMappable {
    
    // JSON -> Object
    public init(map: Map) throws {
        id = try map.value("id")
        title = try map.value("text")
        published = try map.value("publicationDate.milliseconds")
    }
}
