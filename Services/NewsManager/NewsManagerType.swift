//
//  NewsManagerType.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import RxSwift
import Model

public enum NewsManagerError: Error {
    case IndexOutOfRange
}


public protocol NewsManagerType {
    
    func loadFirstPage() -> RxSwift.Observable<[NewsItem]>
    func loadNextPage() -> RxSwift.Observable<[NewsItem]>
    func fetch(by idx: Int) -> RxSwift.Observable<NewsItem>
    func fetch(by id: String) -> RxSwift.Observable<NewsItem>
    func fetchAll() -> RxSwift.Observable<[NewsItem]>

    func incrementViewedCount(for id: String) -> RxSwift.Observable<Void>

}
