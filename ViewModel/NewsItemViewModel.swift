//
//  NewsItemViewModel.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import Model

public final class NewsItemViewModel {
    public let title:String
    
    init (with item:NewsItem) {
        self.title = item.title ?? ""
    }
}
