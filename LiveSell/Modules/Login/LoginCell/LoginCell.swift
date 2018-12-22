//
//  LoginCell.swift
//  LiveCellPad
//
//  Created by Sayanti on 6/22/18.
//  Copyright © 2018 NCRT. All rights reserved.
//

import UIKit

class LoginCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

class LoginTypeCell: UITableViewCell {
    @IBOutlet var btnEmpOrAdmin: UIButton!
}

class LoginEmailCell: UITableViewCell {
    @IBOutlet var txtFiledEmail: UITextField!
}

class LoginPasswordCell: UITableViewCell {
    @IBOutlet var txtFieldPassword: UITextField!
    
}

class LoginRememberMeCell: UITableViewCell {
    @IBOutlet var btnRememberMe: UIButton!
    @IBOutlet var btnForgotPassword: UIButton!
}

class LoginButtonCell: UITableViewCell {
    @IBOutlet var btnLogin: UIButton!
}

class LoginTermsConditionCell: UITableViewCell {
    @IBOutlet var btnTermsAndCondition: UIButton!
    @IBOutlet var btnPrivecyPolicy: UIButton!
    @IBOutlet var btnHelp: UIButton!
    
}
