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
        return NewsItem(id: self.id ?? "", title: self.title, published: self.published, content: self.content, viewedCount: self.viewedCount)
    }
}

extension NewsItem: CoreDataRepresentable {
    func asCDManagedObject() -> CDNews {
        let oldItem: CDNews? = (try! Cd.objectWithID(CDNews.self, idValue: self.id as AnyObject))
        let newsItem:CDNews = oldItem ?? (try! Cd.create(CDNews.self))
        newsItem.id   = self.id
        newsItem.title = self.title ?? newsItem.title
        newsItem.published = self.published 
        newsItem.content = self.content ?? newsItem.content
        newsItem.viewedCount = max(self.viewedCount, newsItem.viewedCount)
        return newsItem
    }
    
    static func cdManagedObjectClass() -> CdManagedObject.Type {
        return CDNews.self
    }
}
