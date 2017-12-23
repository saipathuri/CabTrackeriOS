//
//  Cab.swift
//  CabTracker
//
//  Created by Sai Pathuri on 12/23/17.
//  Copyright © 2017 Sai Pathuri. All rights reserved.
//

import Foundation

struct Cab: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    
    let id: String
    let heading: Int
    let ignition: Bool
    let latitude: String
    let longitude: String
    let moved: String
    let name: String
    let updated: String
    let velocity: Int
    
    var description: String {
        return "Cab: { name: \(name), updated: \(updated) }"
    }
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            let id = representation["id"] as? String,
            let heading = representation["heading"] as? Int,
            let ignition = representation["ignition"] as? Bool,
            let latitude = representation["latitude"] as? String,
            let longitude = representation["longitude"] as? String,
            let moved = representation["moved"] as? String,
            let name = representation["name"] as? String,
            let updated = representation["updated"] as? String,
            let velocity = representation["velocity"] as? Int
        else { return nil }
        self.id = id
        self.heading = heading
        self.ignition = ignition
        self.latitude = latitude
        self.longitude = longitude
        self.moved = moved
        self.name = name
        self.updated = updated
        self.velocity = velocity
    }
    
}
