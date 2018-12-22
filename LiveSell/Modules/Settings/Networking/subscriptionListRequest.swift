//
//  subscriptionListRequest.swift
//  LiveSell
//
//  Created by Amit Chakraborty on 23/07/2018.
//  Copyright © 2018 Aradhana Ray. All rights reserved.
//

import Foundation
import Alamofire
class subscriptionListRequest: APIRequest
{
    public var path: String {
        return "list-company-subscription"
    }
    public var header: [String : String]{
        
        return ["Content-Type": "application/json"]
    }
    public var method: HTTPMethod {
        return .post
    }
    
    
    public var parameters: [String: Any] {
        return ["company_id": company_id]
    }
    
    public var isAuthorized: Bool {
        return false
    }
    
    public var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    private let company_id : String
    
    
    
    init(company_id: String) {
        
        //   self.company_user_id = company_user_id
        self.company_id = company_id
       
        //   self.type = type
        
    }
}
