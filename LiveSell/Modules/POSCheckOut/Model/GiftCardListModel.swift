//
//  GiftCardListModel.swift
//  LiveSell
//
//  Created by Aradhana Ray on 28/06/18.
//  Copyright © 2018 Aradhana Ray. All rights reserved.
//

import Foundation
import ObjectMapper

class GiftCardListModel: Mappable
    
{
    
    var giftList = [GiftCardDetailsModel]()
    var couponList = [CouponCardListModel]()
    var giftcard_list : NSArray!
    public required init?(map: Map)
    {
        
    }
    
    public func mapping(map: Map)
    {
        giftcard_list <- map["giftcard_list"]
        giftList <- map["giftcard_list"]
        couponList <- map["coupon_list"]
        print(giftList.count)
    }
}
