//
//  NewsViewModel.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import Model
import RxSwift
import RxCocoa
import Services

public class NewsViewModel: ViewModelType {
    
    public struct Input {
        public let viewWillAppear: RxCocoa.Driver<Void>
        public let refreshTrigger: RxCocoa.Driver<Void>
        public let nextPageTrigger: RxCocoa.Driver<Void>
        public let itemSelected: Observable<IndexPath>
        public init (viewWillAppear: RxCocoa.Driver<Void>, refreshTrigger: RxCocoa.Driver<Void>, nextPageTrigger: RxCocoa.Driver<Void>, itemSelected: Observable<IndexPath>) {
            self.viewWillAppear = viewWillAppear
            self.refreshTrigger = refreshTrigger
            self.nextPageTrigger = nextPageTrigger
            self.itemSelected = itemSelected
        }
    }
    public struct Output {
        public let fetching: RxCocoa.Driver<Bool>
        public let posts: RxCocoa.Driver<[NewsItemViewModel]>
        public let error: RxCocoa.Driver<Error>
    }
    
    var newsManager: NewsManagerType!
    var router: RouterType!
    
    public func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let reloadTrigger = input.viewWillAppear.asObservable().flatMapLatest { [unowned self] () in
            return self.newsManager.fetchAll()
        }
        let refreshTrigger = Driver.merge(
            input.viewWillAppear.asObservable().take(1).asDriverOnErrorJustComplete(),
            input.refreshTrigger
        )
        let firstNews = refreshTrigger.asObservable().flatMapLatest {
            return self.newsManager.loadFirstPage()
                .trackActivity(activityIndicator)
        }
        let nextNews = input.nextPageTrigger.asObservable().flatMapLatest {
            return self.newsManager.loadNextPage()
        }
        let posts = Observable.merge([reloadTrigger,firstNews,nextNews])
            .map { $0.map { NewsItemViewModel(with: $0) } }
            .trackError(errorTracker)
            .asDriver(onErrorJustReturn: [])
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        _ = input.itemSelected
            .flatMapLatest({ [unowned self] (indexPath) in
                return self.newsManager.fetch(by: indexPath.row)
            })
            .flatMapLatest({ [unowned self] (item) -> Observable<NewsItem> in
                return self.newsManager.incrementViewedCount(for: item.id).map{item}
            })
            .do(onNext: {[unowned self] (newsItem) in
                self.router.openRoute(route: .newsContent(id: newsItem.id), type: .push)
            })
            .subscribe()
        
        return Output(fetching: fetching,
                      posts: posts,
                      error: errors)
    }

}
