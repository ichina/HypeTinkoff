//
//  ServicesAssembly.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 06/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import Swinject
import Model

public class ServicesAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(NewsManagerType.self) { r in
            let mng = NewsManager()
            mng.network = r.resolve(NetworkProvider.self)!.makeNewsNetwork()
            mng.storage = r.resolve(StorageProvider.self)!
            return mng
        }
        
        container.register(NetworkProvider.self) { (r) in
            return NetworkProvider()
        }
        
        container.register(StorageProvider.self) { r in
            return StorageProvider<NewsItem>(stack: r.resolve(CoreDataStack.self)!)
        }
        container.register(CoreDataStack.self) { r in
            return CoreDataStack()
        }.inObjectScope(.container)
        
    }
}
