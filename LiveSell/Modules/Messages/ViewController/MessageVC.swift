//
//  MessageVC.swift
//  LiveCellPad
//
//  Created by Sayanti on 6/25/18.
//  Copyright © 2018 NCRT. All rights reserved.
//

import UIKit

class MessageVC: BaseTabViewController {

    @IBOutlet var messageListingTV: UITableView!
    @IBOutlet var messageDetailsTV: UITableView!
    @IBOutlet var senderMsgTxtView: UITextView!
    @IBOutlet weak var viewMain: UIView!
    
    var selectIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPanGesture()

        self.messageListingTV.delegate = self
        self.messageListingTV.dataSource = self
        self.messageDetailsTV.delegate = self
        self.messageDetailsTV.dataSource = self
        
        self.messageDetailsTV.estimatedRowHeight = 150.0
        self.messageDetailsTV.rowHeight = UITableViewAutomaticDimension
        senderMsgTxtView.delegate = self
        
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .green
        let cancelButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.cancelPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, cancelButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        senderMsgTxtView.inputAccessoryView = toolBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.set(1, forKey: kSelectedIndex)
        menuView?.tblMenu.reloadData()
    }
    @IBAction func sendMessageBtnAction(_ sender: Any) {
        if senderMsgTxtView.text != "Enter your message" {
            print(senderMsgTxtView.text)
        }
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        menuView?.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    @objc func selectionButton (sender: UIButton ){
    }
    
    @objc func cancelPressed(){
        self.view.endEditing(true)
        self.view.frame.origin.y = 0
    }
    override func openSideMenu(){
        isMenu = true
        menuView?.isOpen = isMenu
        menuView?.btnMenu.isSelected = true
        UIView.animate(withDuration: 0.5, animations: {
            
            var frame = self.menuView?.frame
            frame?.origin.x = 0
            self.menuView?.frame = frame!
            
            frame = self.viewMain?.frame
            frame?.origin.x = 230
            self.viewMain?.frame = frame!
            self.menuView?.tblMenu .reloadData()
            self.menuView?.setMenuDesign()
            
        }) { (completion) in
            self.menuView?.tblMenu.isScrollEnabled = true
            self.menuView?.tblMenu .reloadData()
            self.menuView?.setMenuDesign()
            
        }
    }
    
    override func closeSideMenu(){
        isMenu = false
        menuView?.isOpen = isMenu
        menuView?.btnMenu.isSelected = false
        
        UIView.animate(withDuration: 0.5, animations: {
            
            var frame = self.menuView?.frame
            frame?.origin.x = -170
            self.menuView?.frame = frame!
            
            frame = self.viewMain?.frame
            frame?.origin.x = 60
            self.viewMain?.frame = frame!
            self.menuView?.tblMenu .reloadData()
            self.menuView?.setMenuDesign()
        }) { (completion) in
            self.menuView?.tblMenu.isScrollEnabled = true
            self.menuView?.tblMenu .reloadData()
            self.menuView?.setMenuDesign()
            
        }
    }
}
extension MessageVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == messageListingTV {
            return 10
        }else {
            return 15
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == messageListingTV {
            
            let cell : MessageCell? = (tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell)
            cell?.selectListBtn.tag = indexPath.row
            cell?.selectListBtn.isHidden = indexPath.row != selectIndex
            cell?.selectListBtn.addTarget(self, action: #selector(selectionButton), for: .touchUpInside)
            return cell!
        }
        else {
            let cell : MessageDetailsCell? = (tableView.dequeueReusableCell(withIdentifier: "MessageDetailsCell", for: indexPath) as? MessageDetailsCell)
             if indexPath.row % 2 == 0{
                cell?.receiverMsgView.isHidden = true
                cell?.senderMsgView.isHidden = false
             }else {
                cell?.receiverMsgView.isHidden = false
                cell?.senderMsgView.isHidden = true
            }
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if tableView == messageListingTV {
            return 120.0
        }else{
            return 140.0//UITableViewAutomaticDimension
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndex = indexPath.row
        messageListingTV.reloadData()
    }
}
extension MessageVC : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
        self.view.frame.origin.y = -440
        if textView.text == "Enter your message" {
            textView.text = ""
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Enter your message"
        }
         self.view.frame.origin.y = 0
    }
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if(text == "\n") {
//            textView.resignFirstResponder()
//             self.view.frame.origin.y = 0
//            return false
//        }
//        return true
//    }
//
//    /* Older versions of Swift */
//    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
//        if(text == "\n") {
//            textView.resignFirstResponder()
//             self.view.frame.origin.y = 0
//            return false
//        }
//        return true
//    }
}
