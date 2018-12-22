//
//  GiftCardRequest.swift
//  LiveSell
//
//  Created by Aradhana Ray on 28/06/18.
//  Copyright © 2018 Aradhana Ray. All rights reserved.
//

import Foundation
import Alamofire


class GiftCardRequest: APIRequest
{
    //https://liveshop.runmobileapps.com/api/company-process-order
    
    public var path: String {
        return "api/company-process-order"
    }
    public var header: [String : String]{
        
        return ["Content-Type": "application/json"]
    }
    public var method: HTTPMethod {
        return .post
    }
    
    public var parameters: [String: Any] {
        
        return ["company_user_id": company_user_id,"email": email,"cart_id": cart_id,"guest": guest]
    }
    
    public var isAuthorized: Bool {
        return false
    }
    
    public var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    private let company_user_id: Int
    private let email :String!
    private let cart_id:NSArray!
    private let guest: Int
    
    init(companyUserId: Int,email:String,cartId:NSArray,guest:Int ) {
        
        self.company_user_id = companyUserId
        self.email = email
        self.cart_id = cartId
        self.guest = guest
        
    }
}
