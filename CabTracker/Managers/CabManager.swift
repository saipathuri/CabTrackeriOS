//
//  CabManager.swift
//  CabTracker
//
//  Created by Sai Pathuri on 12/23/17.
//  Copyright © 2017 Sai Pathuri. All rights reserved.
//

import Foundation

class CabManager{
    // MARK: - Properties
    
    static let shared = CabManager()
    
    // MARK: -
    
    //key is name of cab
    //value is CabModel object
    var cabs: [String: CabModel]
    
    // Initialization
    
    private init() {
        self.cabs = [String: CabModel]()
    }
    
    func updateCabs(cabs: [String: CabModel]){
        self.cabs = cabs
    }
    
    func updateCabs(cabs: [CabModel]){
        if(self.cabs.count == 0){
            cabs.forEach{ cab in
                self.cabs[cab.name] = cab
            }
        } else{
            cabs.forEach{ cab in
                var cabToUpdate = self.cabs[cab.name]
                cabToUpdate?.updateCab(cab: cab)
            }
        }
    }
    
    func updateCabTrackingEnabled(cabName: String, isTracked: Bool){
        self.cabs[cabName]?.trackingEnabled = isTracked
    }
    
    func getCabs() -> [String: CabModel] {
        return cabs
    }
}
