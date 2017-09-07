//
//  Network.swift
//  HypeTinkoff
//
//  Created by Chingis Gomboev on 07/09/2017.
//  Copyright © 2017 fesolution. All rights reserved.
//

import Foundation

import Alamofire
import RxAlamofire
import RxSwift
import ObjectMapper

final class Network<T: ImmutableMappable> {
    
    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    init(_ endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    func getItems(_ path: String, params: [String: String]) -> Observable<[T]> {
        let paramStr = params.map{[$0.key,$0.value].joined(separator: "=")}.joined(separator: "&")
        let absolutePath = "\(endPoint)/\(path)?\(paramStr)"

        return RxAlamofire
            .json(.get, absolutePath)
            .debug()
            .observeOn(scheduler)
            .map({ json -> [T] in
                guard let jsonDict = json as? [String: Any] else {throw MapError(key: nil, currentValue: json, reason: "Cannot cast to '[String: Any]'")}
                guard let payload = jsonDict["payload"] as? [Any] else {throw MapError(key: nil, currentValue: json, reason: "Cannot parse 'payload' key")}
                return try Mapper<T>().mapArray(JSONObject: payload)
            })
    }
    
    func getItem(_ path: String, itemId: String) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)?id=\(itemId)"
        return RxAlamofire
            .json(.get, absolutePath)
            .debug()
            .observeOn(scheduler)
            .map({ json -> T in
                guard let jsonDict = json as? [String: Any] else {throw MapError(key: nil, currentValue: json, reason: "Cannot cast to '[String: Any]'")}
                guard let payload = jsonDict["payload"] as? [String: Any] else {throw MapError(key: nil, currentValue: json, reason: "Cannot parse 'payload' key")}

                return try Mapper<T>().map(JSONObject: payload)
            })
    }

}
