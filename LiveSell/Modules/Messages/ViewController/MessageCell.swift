//
//  MessageCell.swift
//  LiveCellPad
//
//  Created by Sayanti on 6/25/18.
//  Copyright © 2018 NCRT. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet var selectListBtn: UIButton!
    @IBOutlet var senderMsg: UILabel!
    @IBOutlet var senderImgView: UIImageView!
    @IBOutlet var senderName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        senderImgView.layer.borderWidth = 1
        senderImgView.layer.masksToBounds = false
        senderImgView.layer.borderColor = UIColor.black.cgColor
        senderImgView.layer.cornerRadius = senderImgView.frame.height/2
        senderImgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
class MessageDetailsCell: UITableViewCell {
    @IBOutlet var receiverMsgView: UIView!
    @IBOutlet var receiverMsgLbl: UILabel!
    @IBOutlet var receiverMsgDateLbl: UILabel!
    @IBOutlet var senderMsgView: UIView!
    @IBOutlet var senderMsgLbl: UILabel!
    @IBOutlet var senderDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        receiverMsgLbl.layer.masksToBounds = true
        receiverMsgLbl.layer.cornerRadius = 5
        
        senderMsgLbl.layer.masksToBounds = true
        senderMsgLbl.layer.cornerRadius = 5
        senderMsgLbl.padding = UIEdgeInsets(top: 15, left: 15, bottom: 10, right: 10)
        receiverMsgLbl.padding = UIEdgeInsets(top: 15, left: 15, bottom: 10, right: 10)
    }
}
extension UILabel {
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }
    
    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets!, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        } else {
            self.drawText(in: rect)
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        guard let text = self.text else { return super.intrinsicContentSize }
        
        var contentSize = super.intrinsicContentSize
        var textWidth: CGFloat = frame.size.width
        var insetsHeight: CGFloat = 0.0
        
        if let insets = padding {
            textWidth -= insets.left + insets.right
            insetsHeight += insets.top + insets.bottom
        }
        
        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        attributes: [NSAttributedStringKey.font: self.font], context: nil)
        
        contentSize.height = ceil(newSize.size.height) + insetsHeight
        
        return contentSize
    }
}
