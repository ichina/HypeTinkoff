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
    var storage: NewsStorageProvider!
    
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
            .sorted()
            .do(onNext: { [weak self] _ in
                self?.currentPage += 1
            })
            .observeOn(MainScheduler.asyncInstance)
    }
    
    func fetchAll() -> RxSwift.Observable<[NewsItem]> {
        return storage.fetchObjects().sorted()
    }
    
    func fetch(by idx: Int) -> RxSwift.Observable<NewsItem> {
        return storage.fetchObjects()
            .sorted()
            .flatMap { (arr) -> Observable<NewsItem> in
                if idx < arr.count {
                    return .just(arr[idx])
                }
                else {
                    return .error(NewsManagerError.IndexOutOfRange)
                }
            }
    }

    func fetch(by id: String) -> RxSwift.Observable<NewsItem> {
        let fetch = network.fetchNews(by:id)
            .flatMapLatest {[unowned self] (item) in
                return self.storage.save(object: item).map{item}
            }
        return storage.fetch(with: id).concat(fetch)
    }
    
    func incrementViewedCount(for id: String) -> RxSwift.Observable<Void>{
        return storage.incrementViewedCount(for: id)
    }
}

public struct MapFromNever: Error { public init() {} }
extension ObservableType {// where E == Never {
    func map<T>(to: T.Type) -> Observable<T> {
        return self.flatMap { _ in
            return Observable<T>.error(MapFromNever())
        }
    }
}

extension ObservableType where E == [NewsItem] {
    func sorted() -> Observable<E> {
        return self.map{$0.sorted(by: {$0.0.published > $0.1.published})}
    }
}

