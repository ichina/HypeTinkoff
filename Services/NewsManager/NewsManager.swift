//
//  NewsManager.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Model

class NewsManager: NewsManagerType {
    
    var network: NewsNetwork!
    var storage: StorageProvider<NewsItem>!
    
    private var currentPage = 0
        
    func loadFirstPage() -> RxSwift.Observable<[NewsItem]> {
        currentPage = 0
        
        return storage.deleteObjects()
        .flatMap { [unowned self] _ in return self.loadNextPage()}
    }

    func loadNextPage() -> RxSwift.Observable<[NewsItem]> {
        
        return network.fetchNews(page: currentPage)
            .flatMap { [unowned self] arr in
                return self.storage.save(objects: arr)
            }
            .flatMap { [unowned self] _ in
                return self.storage.fetchObjects()
            }
            .map{$0.sorted(by: {$0.0.published > $0.1.published})}
            .do(onNext: { [weak self] _ in
                self?.currentPage += 1
            })
            .observeOn(MainScheduler.asyncInstance)
    }

}

struct MapFromNever: Error {}
extension ObservableType {// where E == Never {
    func map<T>(to: T.Type) -> Observable<T> {
        return self.flatMap { _ in
            return Observable<T>.error(MapFromNever())
        }
    }
}
