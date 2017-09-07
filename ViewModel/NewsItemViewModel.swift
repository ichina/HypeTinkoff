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
    public let viewedCount:String
    
    init (with item:NewsItem) {
        self.title = item.title?.clean ?? ""
        self.viewedCount = "views: \(item.viewedCount)"
    }
}

extension String {
    var clean: String {
        let myregex = "<[^>]*>";//"<[^>]+>" //regex to remove any html tag
        return self.replacingOccurrences(of: myregex, with: " ", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "&nbsp;", with: " ")
    }
}
