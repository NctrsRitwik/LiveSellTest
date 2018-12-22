//
//  OrderDetailsiPadCell.swift
//  LiveSell
//
//  Created by Dipanjan on 7/14/18.
//  Copyright © 2018 Aradhana Ray. All rights reserved.
//

import UIKit

class OrderDetailsiPadCell: UITableViewCell {
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblUnitPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblCouponDiscountPercent: UILabel!
    @IBOutlet weak var lblTaxDiscountPercent: UILabel!
    @IBOutlet weak var lblAfterDiscountAmmount: UILabel!
    @IBOutlet weak var lblAfterTaxAmmount: UILabel!
    @IBOutlet weak var lblTotalAmmount: UILabel!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblGlobalDiscount: UILabel!
    @IBOutlet weak var globalDiscountPercent: UILabel!
    @IBOutlet weak var lblGlobalDiscountPrice: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
