//
//  Router.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import Swinject

public class Router: RouterType {
    
    private let resolver: Resolver
    public init(resolver: Resolver) {
        self.resolver = resolver
    }
    public func openRoute(route: AppRoute, type: RouteType) -> Bool {

        var vc: UIViewController
        switch route {
        case .newsFeed:
            vc = resolver.resolve(UIViewController.self, name: "newsFeed")!
        case .newsContent(let id):
            vc = resolver.resolve(UIViewController.self, name: "newsContent", argument: id)!
        }
        
        return open(vc: vc, type: type)
    }
    
    private func open(vc: UIViewController, type: RouteType) -> Bool {
        switch type {
        case .asRootWith(let window):
            window.rootViewController = vc
            return true
        case .push:
            if let nv = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
                nv.pushViewController(vc, animated: true)
                return true
            }
            return false
        default:
            return false
        }
    }
}
