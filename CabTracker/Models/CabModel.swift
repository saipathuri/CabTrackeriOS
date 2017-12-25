//
//  Cab.swift
//  CabTracker
//
//  Created by Sai Pathuri on 12/23/17.
//  Copyright © 2017 Sai Pathuri. All rights reserved.
//

import Foundation
import GoogleMaps

struct CabModel: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    
    var id: String
    var heading: Int
    var ignition: Bool
    var latitude: String
    var longitude: String
    var moved: String
    var name: String
    var updated: String
    var velocity: Int
    var marker: GMSMarker?

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
        self.marker = nil
    }
    
    mutating func updateCab(cab: CabModel){
        self.id = cab.id
        self.heading = cab.heading
        self.ignition = cab.ignition
        self.latitude = cab.latitude
        self.longitude = cab.longitude
        self.moved = cab.moved
        self.name = cab.name
        self.updated = cab.updated
        self.velocity = cab.velocity
    }

}
