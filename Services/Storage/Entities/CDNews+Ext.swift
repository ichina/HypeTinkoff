//
//  CDNews+Ext.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import Model
import Cadmium

extension CDNews: DomainConvertibleType {
    func asDomain() -> NewsItem {
        return NewsItem(id: self.id ?? "", title: self.title, published: self.published)
    }
}

extension NewsItem: CoreDataRepresentable {
    func asCDManagedObject() -> CDNews {
        let newsItem = try! Cd.create(CDNews.self)
        newsItem.id   = self.id
        newsItem.title = self.title
        newsItem.published = self.published
        return newsItem
    }
}
