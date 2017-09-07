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
    
    func fetchObjects() -> Observable<[NewsItem]> {
        do {
            let arr = try Cd.objects(CDNews.self).fetch()
            return Observable.just(arr.map{($0 as CDNews).asDomain()})
        } catch let err {
            return .error(err)
        }
    }
    
    func deleteObjects() -> Observable<Void> {
        Cd.transact(serial: true) { () in
            try? Cd.objects(CDNews.self).delete()
        }
        return .just()
    }
}
