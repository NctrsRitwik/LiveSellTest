//
//  POSCheckOutTableViewCell.swift
//  LiveSell
//
//  Created by Aradhana Ray on 09/06/18.
//  Copyright © 2018 Aradhana Ray. All rights reserved.
//

import UIKit

class POSCheckOutTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCouponType: UILabel!
    @IBOutlet weak var lblCouponDetails: UILabel!    
    @IBOutlet weak var lblCouponName: UILabel!
    @IBOutlet weak var imgSeleted: UIImageView!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var imgCoupon: UIImageView!
    @IBOutlet weak var btnCellTap: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
