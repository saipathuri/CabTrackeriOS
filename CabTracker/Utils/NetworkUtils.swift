//
//  NetworkUtils.swift
//  CabTracker
//
//  Created by Sai Pathuri on 12/23/17.
//  Copyright © 2017 Sai Pathuri. All rights reserved.
//

import Alamofire

class NetworkUtils {
    static let ENDPOINT_URL = "https://t8ubh7xmac.execute-api.us-east-2.amazonaws.com/Test"

    static func makeRequest(){
        Alamofire.request(ENDPOINT_URL)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseCollection { (response: DataResponse<[Cab]>) in
                debugPrint(response)
                
                print("printing cabs: ")
                if let cabs = response.result.value {
                    cabs.forEach { print("- \($0.name)") }
                }
            }
    }

}
