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

public protocol NewsManagerType {
    
    func loadFirstPage() -> RxSwift.Observable<[NewsItem]>
    func loadNextPage() -> RxSwift.Observable<[NewsItem]>
}
