//
//  GiftCardDetailsModel.swift
//  LiveSell
//
//  Created by Aradhana Ray on 28/06/18.
//  Copyright © 2018 Aradhana Ray. All rights reserved.
//

import Foundation
import ObjectMapper

class GiftCardDetailsModel: Mappable
    
{
    
    
    var comment: String!
    var company_id: String!
    var giftcard_amount: String!
    var giftcard_expiry_date: String!
    var giftcard_issue_id: Int!
    var giftcard_name: String!
    var giftcard_number: String!
    var giftcard_seared_id: Int!
    var info: String!
    
    
    public required init?(map: Map)
    {
        
    }
    
    public func mapping(map: Map)
    {
        giftcard_expiry_date <- map["giftcard_expiry_date"]
         comment <- map["comment"]
         company_id <- map["company_id"]
         giftcard_amount <- map["giftcard_amount"]
         giftcard_issue_id <- map["giftcard_issue_id"]
         giftcard_name <- map["giftcard_name"]
         giftcard_number <- map["giftcard_number"]
         giftcard_seared_id <- map["giftcard_seared_id"]
         info <- map["info"]
        
    }
}
