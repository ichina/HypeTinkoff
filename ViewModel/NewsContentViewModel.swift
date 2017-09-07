//
//  NewsContentViewModel.swift
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

public class NewsContentViewModel: ViewModelType {
    public struct Input {
        public let refreshTrigger: RxCocoa.Driver<Void>
        public init (refreshTrigger: RxCocoa.Driver<Void>) {
            self.refreshTrigger = refreshTrigger
        }
    }
    
    public struct Output {
        public let fetching: RxCocoa.Driver<Bool>
        public let content: RxCocoa.Driver<String>
        public let error: RxCocoa.Driver<Error>
    }
    
    private let newsID: String
    var newsManager: NewsManagerType!
    
    public init(newsID: String) {
        self.newsID = newsID
    }
    
    public func transform(input: Input) -> Output {
        
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let content = input.refreshTrigger.asObservable().flatMapLatest { [unowned self] _ in
            return self.newsManager.fetch(by: self.newsID)
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .map { $0.content?.clean ?? "" }
        }
        .asDriver(onErrorJustReturn: "")
        
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        return Output(fetching: fetching,
                      content: content,
                      error: errors)
//         */
//        let fetching = Observable.just(false).asDriver(onErrorJustReturn: false)
//        let errors = Observable.just((NSError() as Error)).asDriver(onErrorJustReturn: (NSError() as Error))
//        return Output(fetching: fetching,
//                      content: content,
//                      error: errors)
    }

}
