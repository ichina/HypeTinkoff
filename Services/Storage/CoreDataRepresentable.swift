//
//  CoreDataRepresentable.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import CoreData
import Cadmium

protocol DomainConvertibleType {
    associatedtype DomainType
    
    func asDomain() -> DomainType
}



protocol CoreDataRepresentable {
    associatedtype CoreDataType: CdManagedObject

    func asCDManagedObject() -> CoreDataType
}

