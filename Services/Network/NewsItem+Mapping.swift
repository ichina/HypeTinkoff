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
        print(map.JSON)
        id = (try? map.value("id")) ?? ((try? map.value("title.id")) ?? "")
        title = (try? map.value("text")) ?? ((try? map.value("title.text")) ?? "")
        published = (try? map.value("publicationDate.milliseconds")) ?? ((try? map.value("title.publicationDate.milliseconds")) ?? 0)
        content = try? map.value("content")
        viewedCount = 0
    }
}
