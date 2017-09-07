//
//  UITableView+RxNextPage.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UITableView {
    public var didScrollToBottom: Observable<Void> {
        
        return self.contentOffset
            .filter { (offset) -> Bool in
                return (self.base.contentSize.height > self.base.frame.height*1.5) && ((self.base.contentSize.height - self.base.frame.height) < offset.y)
            }
            .throttle(0.3, scheduler: MainScheduler.asyncInstance)
            .mapToVoid()
        
        
    }
}
