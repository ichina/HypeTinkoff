//
//  NewsStorageProvider.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import Cadmium
import Model
import RxSwift

class NewsStorageProvider: StorageProvider<NewsItem> {
    
    func fetchObjects() -> Observable<[NewsItem]> {
        do {
            let arr = try Cd.objects(CDNews.self).fetch()
            return Observable.just(arr.map{ $0.asDomain()})
        } catch let err {
            return .error(err)
        }
    }
    
    func fetch(with id: String) -> Observable<NewsItem> {
        do {
            if let obj = try Cd.objectWithID(CDNews.self, idValue: id as AnyObject) {
                return Observable.just(obj.asDomain())
            }
            return .error(StorageProviderError.ObjectNotFound)
        } catch let err {
            return .error(err)
        }
    }
    
    func deleteObjects() -> Observable<Void> {
        Cd.transact(serial: true) { () in
            try? Cd.objects(CDNews.self).delete()
        }
        return .just()
    }
    
    func incrementViewedCount(for id: String) -> Observable<Void> {
        Cd.transact(serial: true) { () in
            guard let obj = try! Cd.objectWithID(CDNews.self, idValue: id as AnyObject),
                let newsItem = Cd.useInCurrentContext(obj) else { return }
                
            newsItem.viewedCount += 1
        }
        return .just()
    }

}
