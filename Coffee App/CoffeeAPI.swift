//
//  CoffeeAPI.swift
//  Coffee App
//
//  Created by Tim Lee on 10/3/15.
//  Copyright © 2015 Tim Lee. All rights reserved.
//

import Foundation

class CoffeeAPI {
    
    var networking:Networking
    let baseURL = "https://coffeeapi.percolate.com/"
    
    init(apiKey: String) {
        self.networking = Networking(apiKey: apiKey)
    }
    
    func getCoffeeList(success: Networking.SuccessHandler, failure:Networking.FailureHandler) -> () {
        let endPoint = "api/coffee/"
        let parameters = [:]
        let url = NSURL(string:endPoint, relativeToURL:NSURL(string:self.baseURL))
        
        self.networking.httpGET(url!, parameters:parameters,
            success:success, failure:failure)
    }
    
    func getCoffeeDetails(id: String, success: Networking.SuccessHandler, failure:Networking.FailureHandler) -> () {
        let endPoint = "api/coffee/" + id
        let parameters = [:]
        let url = NSURL(string:endPoint, relativeToURL:NSURL(string:self.baseURL))
        
        self.networking.httpGET(url!, parameters:parameters,
            success:success, failure:failure)
    }
}