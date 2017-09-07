//
//  CoreDataStack.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation
import Cadmium
import Model

final class CoreDataStack {
    public init() {
        do {
            let bundle = Bundle(identifier: "com.fesolution.Services")!
            let momdURL = bundle.url(forResource: "TinkoffModel", withExtension: "mom")!

            var sqliteURL: URL? = nil
            let filename = "TinkoffDB.sqlite"
            let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentDirectory   = documentDirectories[documentDirectories.count - 1]
            sqliteURL               = documentDirectory.appendingPathComponent(filename)
            
            try FileManager.default.createDirectory(at: documentDirectory, withIntermediateDirectories: true, attributes: nil)
            

            
            try Cd.initWithSQLStore(momdURL: momdURL, sqliteURL: sqliteURL)
        } catch let error {
            print("\(error)")
        }
    }
    
    
}
