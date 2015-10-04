//
//  Networking.swift
//  Coffee App
//
//  Created by Tim Lee on 10/3/15.
//  Copyright © 2015 Tim Lee. All rights reserved.
//

import Foundation

class Networking {
    
    typealias SuccessHandler = (AnyObject!) -> ()
    typealias FailureHandler = (Int, String!) -> ()
    let getManager:AFHTTPRequestOperationManager

    init(apiKey: String? = nil) {
        self.getManager = AFHTTPRequestOperationManager()
        let requestSerializer = AFHTTPRequestSerializer()
        if apiKey != nil {
            requestSerializer.setValue(apiKey, forHTTPHeaderField:"Authorization")
        }
        self.getManager.requestSerializer = requestSerializer
    }
    
    func httpGET(url: NSURL, parameters: NSDictionary?,
        success: SuccessHandler?, failure: FailureHandler?) -> () {            
            self.getManager.GET(url.absoluteString,
                parameters:parameters,
                success:{(operation:AFHTTPRequestOperation!, responseObject:AnyObject!) in
                    if success != nil {
                        success!(responseObject)
                    }
                } ,
                failure:{(operation:AFHTTPRequestOperation!, error:NSError!) in
                    if (failure != nil) {
                        failure!(operation.response == nil ? 0 : operation.response.statusCode, operation.response == nil ? "" : operation.responseString)
                    }
            })
    }
}