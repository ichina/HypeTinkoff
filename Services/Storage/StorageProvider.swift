//
//  StorageProvider.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import RxSwift
import Cadmium
import Model

class StorageProvider<T: CoreDataRepresentable> {
    
    private let stack: CoreDataStack
    init(stack: CoreDataStack) {
        self.stack = stack
    }
    
    func save(object: T) -> Observable<Void> {
        return Observable.create({ observer -> Disposable in
            Cd.transact { () in
                _ = object.asCDManagedObject()
                observer.onNext()
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }

    func save(objects: [T]) -> Observable<Void> {
        return Observable.create({ observer -> Disposable in
            Cd.transact { () in
                _ = objects.map({$0.asCDManagedObject()})
                observer.onNext()
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }
    
}

enum StorageProviderError: Error {
    case ObjectNotFound
}
