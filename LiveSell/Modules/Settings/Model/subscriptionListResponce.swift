//
//  subscriptionListResponce.swift
//  LiveSell
//
//  Created by Amit Chakraborty on 23/07/2018.
//  Copyright © 2018 Aradhana Ray. All rights reserved.
//

import Foundation
import ObjectMapper

class subscriptionListResponce: Mappable
    
{
    var arrList = [subscriptionListModel]()
    
    public required init?(map: Map)
    {
        
    }
    
    public func mapping(map: Map)
    {
        arrList <- map["list_zip"]
        print(arrList.count)
    }
}
