//
//  GiftCardTableViewCell.swift
//  LiveSell
//
//  Created by Aradhana Ray on 29/06/18.
//  Copyright © 2018 Aradhana Ray. All rights reserved.
//

import UIKit

class GiftCardTableViewCell: UITableViewCell {
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var lblCardNo: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnGiftCard: UIButton!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var imgvwGiftBg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
