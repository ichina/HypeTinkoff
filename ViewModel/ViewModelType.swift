//
//  ViewModelType.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
