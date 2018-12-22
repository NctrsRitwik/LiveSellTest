
//  DeleteSubscriptionRequest.swift
//  LiveSell
//
//  Created by Amit Chakraborty on 23/07/2018.
//  Copyright © 2018 Aradhana Ray. All rights reserved.


import Foundation
import Alamofire
class DeleteSubscriptionRequest: APIRequest
{
    public var path: String {
        return "remove-company-subscription"
    }
    public var header: [String : String]{
        
        return ["Content-Type": "application/json"]
    }
    public var method: HTTPMethod {
        return .post
    }
    
    
    public var parameters: [String: Any] {
        return ["company_id": company_id,"id": id]
    }
    
    public var isAuthorized: Bool {
        return false
    }
    
    public var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    private let company_id : String
    private let id : String
    
    
    init(company_id: String,id:String) {
        
        //   self.company_user_id = company_user_id
        self.company_id = company_id
        self.id = id
        
        //   self.type = type
        
    }
}
