//
//  ViewAssembly.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 06/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import Swinject
//import SwinjectStoryboard
import ViewModel

public class ViewAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {

        container.register(NewsContentController.self) { (r: Resolver, arg: String) in
            let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = sb.instantiateViewController(withIdentifier: "newsContentController") as! NewsContentController
            vc.viewModel = r.resolve(NewsContentViewModel.self, argument: arg)
            
            return vc
        }
        
        container.register(UIViewController.self, name: "newsContent") { (r: Resolver, arg: String) in
            return r.resolve(NewsContentController.self, argument: arg)!
        }
        
        container.register(UIViewController.self, name: "newsFeed") { r in
            let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = sb.instantiateViewController(withIdentifier: "newsController") as! NewsController
            vc.viewModel = r.resolve(NewsViewModel.self)
            let nv = UINavigationController(rootViewController: vc)
            return nv
        }
        
    }
}
