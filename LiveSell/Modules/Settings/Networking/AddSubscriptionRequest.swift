//
//  AddSubscriptionRequest.swift
//  LiveSell
//
//  Created by Amit Chakraborty on 23/07/2018.
//  Copyright © 2018 Aradhana Ray. All rights reserved.
//

import Foundation
import Alamofire
class AddSubscriptionRequest: APIRequest
{
    public var path: String {
        return "add-company-subscription"
    }
    public var header: [String : String]{
        
        return ["Content-Type": "application/json"]
    }
    public var method: HTTPMethod {
        return .post
    }
    
    
    public var parameters: [String: Any] {
        return ["company_id": company_id,"subscription_day": subscription_day,"subscription_discount": subscription_discount]
        
        //company_id22subscription_days90subscription_discount6
    }
    
    public var isAuthorized: Bool {
        return false
    }
    
    public var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    private let company_id : String
    private let subscription_day : String
    private let subscription_discount : String
    
    init(company_id: String,subscription_day: String,subscription_discount: String) {
        
        //   self.company_user_id = company_user_id
        self.company_id = company_id
        self.subscription_day = subscription_day
        self.subscription_discount = subscription_discount
        //   self.type = type
        
    }
}
