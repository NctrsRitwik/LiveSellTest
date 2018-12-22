//
//  OrdersViewController.swift
//  LiveSell
//
//  Created by Rasmiranjan Sahu on 22/06/18.
//  Copyright © 2018 NCRTS. All rights reserved.
//

import UIKit

class OrdersViewController: BaseTabViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var viewOrderDetailsStatus: UIView!
    @IBOutlet weak var tblOrderList: UITableView!
    @IBOutlet weak var tblOrderCategory: UITableView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var btnDelivered: UIButton!
    @IBOutlet weak var btnWait: UIButton!
    @IBOutlet weak var btnComing: UIButton!
    @IBOutlet weak var viewOrderDetails: UIView!
    @IBOutlet weak var tblItemList: UITableView!
    @IBOutlet weak var viewOrder: UIView!
    @IBOutlet weak var viewOrderList: UIView!
    @IBOutlet weak var viewShippingCharge: UIView!
    @IBOutlet weak var viewOrderDetailsBottom: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet var viewFooter: UIView!
    @IBOutlet weak var lblOrderCategory: UILabel!
    @IBOutlet weak var btnOrderDetDelivered: UIButton!
    @IBOutlet weak var btnOrderDetWait: UIButton!
    @IBOutlet weak var btnOrderDetComing: UIButton!
    @IBOutlet weak var lblOrderDEtStatus: UILabel!

    var indexSelect = IndexPath()
    var indexCat = 0
    
    let arrOrderCat = ["Active Orders","Delivered Orders","Cancelled Orders","All Orders"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPanGesture()
        viewStatus.isHidden = true
        viewOrderDetailsStatus.isHidden = true

        tblItemList.register(UINib(nibName: "OrderDetailsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "OrderDetailsTableViewCell")
        
        let when = DispatchTime.now() + 0.3 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
        
            var frame = self.viewOrderDetails.frame
            frame.origin.x = self.viewMain.frame.size.width
            self.viewOrderDetails.frame = frame
            
        }

//        viewOrderDetails.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.set(0, forKey: kSelectedIndex)
        menuView?.tblMenu.reloadData()
    }
    
    //Mark:-
    //Mark:- Tableview Delegate & DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblOrderList{
            return 20
        }else{
            return arrOrderCat.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblOrderList{
            
            if indexPath.row == 0{
                let cell : OrderListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell1") as! OrderListTableViewCell
                
                cell.selectionStyle = .none
                
                return cell
            }else{
                let cell : OrderListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell2") as! OrderListTableViewCell
                cell.selectionStyle = .none
                cell.index = indexPath
                cell.onClickOrderStatus = {(_ index : IndexPath, _ frame : CGRect) -> Void in

                    let rectInTableView = tableView.rectForRow(at: index)
                    
                    self.viewStatus.isHidden = false
                    
                    var frame = self.viewStatus.frame
                    frame.origin.y = rectInTableView.origin.y + 80
                    frame.size.height = 160
                    self.viewStatus.frame = frame
                    
                    self.indexSelect = index
                }

                return cell
            }
        }else if tableView == tblItemList{
            
            let cell : OrderDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailsTableViewCell") as! OrderDetailsTableViewCell
            cell.selectionStyle = .none
            return cell
            
        }else{
            let cell : OrderCategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "OrderCategoryTableViewCell") as! OrderCategoryTableViewCell
                
            cell.lblCatName.text = arrOrderCat[indexPath.row]
            cell.selectionStyle = .none
                
            if indexPath.row == indexCat{
                cell.lblCatName.textColor = UIColor.black
                cell.lblCatName.font = UIFont.boldSystemFont(ofSize: 17.0)
                cell.lblCount.font = UIFont.boldSystemFont(ofSize: 17.0)

            }else{
                cell.lblCatName.textColor = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
                cell.lblCatName.font = UIFont.systemFont(ofSize: 17.0)
                cell.lblCount.font = UIFont.systemFont(ofSize: 17.0)

            }

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblOrderList{
            return 80
        }else if tableView == tblItemList{
            return 240
        }else{
            
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblOrderCategory{
            
            indexCat = indexPath.row
            tblOrderCategory.reloadData()
            lblOrderCategory.text = arrOrderCat[indexPath.row]
        }else if tableView == tblOrderList{
            if indexPath.row != 0{
                UIView.animate(withDuration: 0.3) {
                    var frame = self.viewOrderDetails.frame
                    frame.origin.x = self.viewOrderList.frame.origin.x
                    self.viewOrderDetails.frame = frame
//                    self.viewOrderDetails.isHidden = false
                }
            }
        }else if tableView == tblItemList{
            let CreateItemVC = self.storyboard?.instantiateViewController(withIdentifier: "CreateItemVC") as! CreateItemVC
            self.navigationController?.pushViewController(CreateItemVC, animated: false)
        }
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
        
//        frame = self.tblOrderList?.frame
//        frame?.origin.x = 670
//        self.tblOrderList?.frame = frame!
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
        
//        frame = self.tblOrderList?.frame
//        frame?.origin.x = 500
//        self.tblOrderList?.frame = frame!
    }

    @IBAction func onClickStatus(_ sender: UIButton) {
        
        viewStatus.isHidden = true
        
        let cell : OrderListTableViewCell = tblOrderList.cellForRow(at: indexSelect) as! OrderListTableViewCell
        if sender.tag == 10{
            cell.btnStatus.setTitle("Coming", for: .normal)
            cell.btnStatus.setTitleColor(UIColor(red: 67/255.0, green: 112/255.0, blue: 132/255.0, alpha: 1.0), for: .normal)
            btnComing.isSelected = true
            btnWait.isSelected = false
            btnDelivered.isSelected = false

        }else if sender.tag == 11{
            cell.btnStatus.setTitle("Wait Ready", for: .normal)
            cell.btnStatus.setTitleColor(UIColor.orange, for: .normal)
            btnWait.isSelected = true
            btnComing.isSelected = false
            btnDelivered.isSelected = false
        }else{
            cell.btnStatus.setTitle("Delivered", for: .normal)
            cell.btnStatus.setTitleColor(UIColor.green, for: .normal)
            btnDelivered.isSelected = true
            btnComing.isSelected = false
            btnWait.isSelected = false
        }
    }
    
    @IBAction func onClickOrderDetailsStatusChange(_ sender: UIButton) {
        
        viewOrderDetailsStatus.isHidden = true

        if sender.tag == 20{
            lblOrderDEtStatus.text = "Coming"
            lblOrderDEtStatus.textColor = UIColor(red: 67/255.0, green: 112/255.0, blue: 132/255.0, alpha: 1.0)
            btnOrderDetComing.isSelected = true
            btnOrderDetWait.isSelected = false
            btnOrderDetDelivered.isSelected = false
            
        }else if sender.tag == 21{
            lblOrderDEtStatus.text = "Wait Ready"
            lblOrderDEtStatus.textColor = UIColor.orange
            btnOrderDetWait.isSelected = true
            btnOrderDetComing.isSelected = false
            btnOrderDetDelivered.isSelected = false
        }else{
            lblOrderDEtStatus.text = "Delivered"
            lblOrderDEtStatus.textColor = UIColor.green
            btnOrderDetDelivered.isSelected = true
            btnOrderDetComing.isSelected = false
            btnOrderDetWait.isSelected = false
        }
    }
    @IBAction func onClickOrderDetailsStatus(_ sender: Any) {
        viewOrderDetailsStatus.isHidden = false

    }
    @IBAction func onClickOrderDetailsBack(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3) {
            var frame = self.viewOrderDetails.frame
            frame.origin.x = self.viewMain.frame.size.width
            self.viewOrderDetails.frame = frame
//            self.viewOrderDetails.isHidden = true
        }
    }
}

