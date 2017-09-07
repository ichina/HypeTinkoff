//
//  RouterType.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation

public enum AppRoute {
    case newsFeed
    case newsContent(id: String)
}

extension AppRoute {
    var rawValue: String {
        switch self {
        case .newsFeed: return "newsFeed"
        case .newsContent(let id): return "newsContent-\(id)"
        }
    }
}

public enum RouteType {
    case asRootWith(window: UIWindow)
    case push
    case present
}

public protocol RouterType {
    @discardableResult func openRoute(route: AppRoute, type: RouteType) -> Bool
}
