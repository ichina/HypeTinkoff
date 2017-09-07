//
//  ApplicationAssembly.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 06/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import Swinject
//import SwinjectStoryboard
import Then
import Services
import View
import ViewModel
import Model

class ApplicationAssembly {
    private let assembler = Assembler([
        ViewAssembly(),
        ViewModelAssembly(),
        ServicesAssembly()
        ])
    var resolver: Resolver {
        return assembler.resolver
    }
}
let appAssembly = ApplicationAssembly()

/*
extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer.storyboardInitCompleted(UINavigationController.self) { r, c in
        }
        defaultContainer.storyboardInitCompleted(NewsController.self) { r, c in
            c.viewModel = appAssembly.resolver.resolve(NewsViewModel.self)!
        }
        
//        defaultContainer.storyboardInitCompleted(NewsController.self) { r, c in
//            c.viewModel = appAssembly.resolver.resolve(NewsViewModel.self)!
//        }
    }
}
*/
