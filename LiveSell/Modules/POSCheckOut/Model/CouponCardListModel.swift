//
//  CouponCardListModel.swift
//  LiveSell
//
//  Created by Aradhana Ray on 29/06/18.
//  Copyright © 2018 Aradhana Ray. All rights reserved.
//

import Foundation
import ObjectMapper

class CouponCardListModel: Mappable
    
{
    
    
    var coupon_id: Int!
    var coupon_code: String!
    var description: String!
    var company_name: String!
    var discount_type: String!
    var discount: Int!
    var customer_id: String!
    var logo: String!
    var coupon_expiry_date : String!
    var alowed_usage : String!
    
    public required init?(map: Map)
    {
        
    }
    
    public func mapping(map: Map)
    {
        alowed_usage <- map["alowed_usage"]
        discount <- map["discount"]
        coupon_expiry_date <- map["coupon_expiry_date"]
        coupon_id <- map["coupon_id"]
        coupon_code <- map["coupon_code"]
        description <- map["description"]
        company_name <- map["company_name"]
        discount_type <- map["discount_type"]
        discount <- map["discount"]
        customer_id <- map["customer_id"]
        logo <- map["customer_id"]
        
    }
}
