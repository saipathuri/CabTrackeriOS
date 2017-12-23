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
    
    var cabs: [String: CabModel]
    
    // Initialization
    
    private init() {
        self.cabs = [String: CabModel]()
    }
    
    func updateCabs(cabs: [CabModel]){
        if(self.cabs.count == 0){
            //TODO: if list is empty, then insert
            cabs.forEach{ cab in
                self.cabs[cab.name] = cab
            }
        } else{
            //TODO: if list is populated, then update
            cabs.forEach{ cab in
                var cabToUpdate = self.cabs[cab.name]
                cabToUpdate?.updateCab(cab: cab)
            }
        }
    }
    
    func getCabs() -> [String: CabModel] {
        return cabs
    }
}
