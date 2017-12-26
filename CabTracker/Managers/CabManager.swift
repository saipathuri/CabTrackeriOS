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
    private var cabs: [String: CabModel]
    
    // Initialization
    
    private init() {
        self.cabs = [String: CabModel]()
    }
    
    // replaces the dictionary with a new one
    func updateCabs(cabs: [String: CabModel]){
        self.cabs = cabs
    }
    
    func updateCabs(cabs: [CabModel]){
        // if there are no cabs stored
        // add all cabs to the dictionary
        // and load if they should appear from UserDefaults
        if(self.cabs.count == 0){
            cabs.forEach{ cab in
                self.cabs[cab.name] = cab
                // if the value exists, then the expression does not return nil
                // if it returns nil, that means the value isn't stored so use True by default
                // if it exists, then use it
                self.cabs[cab.name]?.trackingEnabled = getTrackingStatusFromDefaults(cab: cab)
            }
        // if there are cabs stored
        // then call the information update function on each cab
        // we do this to not overwrite the marker
        } else{
            cabs.forEach{ cab in
                var cabToUpdate = self.cabs[cab.name]
                cabToUpdate?.updateCab(cab: cab)
            }
        }
    }
    
    // used to update if the function should be called or not
    func updateCabTrackingEnabled(cabName: String, isTracked: Bool){
        self.cabs[cabName]?.trackingEnabled = isTracked
    }
    
    func getCabs() -> [String: CabModel] {
        return cabs
    }
    
    func getTrackingStatusFromDefaults(cab: CabModel) -> Bool {
        return UserDefaults.standard.object(forKey: cab.name) == nil ? true : UserDefaults.standard.bool(forKey: cab.name)
    }
}
