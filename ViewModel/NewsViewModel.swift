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
        public let refreshTrigger: RxCocoa.Driver<Void>
        public let nextPageTrigger: RxCocoa.Driver<Void>
        public init (refreshTrigger: RxCocoa.Driver<Void>, nextPageTrigger: RxCocoa.Driver<Void>) {
            self.refreshTrigger = refreshTrigger
            self.nextPageTrigger = nextPageTrigger
        }
    }
    public struct Output {
        public let fetching: RxCocoa.Driver<Bool>
        public let posts: RxCocoa.Driver<[NewsItemViewModel]>
        public let error: RxCocoa.Driver<Error>
    }
    
    var newsManager: NewsManagerType!
    
    public func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let firstNews = input.refreshTrigger.asObservable().flatMapLatest {
            return self.newsManager.loadFirstPage()
                .trackActivity(activityIndicator)
                .map { $0.map { NewsItemViewModel(with: $0) } }
        }
        let nextNews = input.nextPageTrigger.asObservable().flatMapLatest {
            return self.newsManager.loadNextPage()
                .map { $0.map { NewsItemViewModel(with: $0) } }
        }
        let posts = Observable.merge([firstNews,nextNews])
            .trackError(errorTracker)
            .asDriver(onErrorJustReturn: [])
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()

        return Output(fetching: fetching,
                      posts: posts,
                      error: errors)
    }

}
