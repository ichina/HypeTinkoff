//
//  ViewModelAssembly.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import Swinject
import Services

public class ViewModelAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(NewsViewModel.self) { r in
            let vm = NewsViewModel()
            vm.newsManager = r.resolve(Services.NewsManagerType.self)!
            vm.router = r.resolve(Services.RouterType.self)!
            return vm
        }
        
        container.register(NewsContentViewModel.self) { (r: Resolver, arg: String) in
            let vm = NewsContentViewModel(newsID: arg)
            vm.newsManager = r.resolve(Services.NewsManagerType.self)!
            return vm
        }
    }
}
