//
//  CategoryDetails.swift
//  LiveSell
//
//  Created by Aradhana Ray on 13/06/18.
//  Copyright © 2018 Aradhana Ray. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoryDetails: Mappable
    
{
    var cond_id: String!
    var cond: String!
    var desc : String!
    
    public required init?(map: Map)
    {
        
    }
    
    public func mapping(map: Map)
    {
        cond_id <- map["id"]
        cond <- map["name"]
        desc <- map["description"]
    }
    
}
