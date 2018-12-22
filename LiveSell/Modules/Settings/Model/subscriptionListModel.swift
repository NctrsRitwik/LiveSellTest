//
//  subscriptionListModel.swift
//  LiveSell
//
//  Created by Amit Chakraborty on 23/07/2018.
//  Copyright © 2018 Aradhana Ray. All rights reserved.
//

import Foundation
import ObjectMapper

class subscriptionListModel: Mappable
    
{
    
        var subscription_days: Int!
        var id: Int!
        var subscription_discount: String!
        var status:Int!
        var created_at: String!
    //    var review_stat:NSDictionary!
    
    public required init?(map: Map)
    {
        
    }
    
    public func mapping(map: Map)
    {
                subscription_days <- map["subscription_days"]
                id <- map["id"]
                subscription_discount <- map["subscription_discount"]
                status <- map["status"]
                created_at <- map["created_at"]
        //        review_stat <- map["review_stat"]
        
        
        // print(result)
    }
}
