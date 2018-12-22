//
//  POSCheckOutViewController.swift
//  LiveSell
//
//  Created by Aradhana Ray on 08/06/18.
//  Copyright © 2018 Aradhana Ray. All rights reserved.
//

import UIKit

class POSCheckOutViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var lblGlobalDiscount: UILabel!
    @IBOutlet weak var lblGDiscount: UILabel!
    @IBOutlet weak var vwGlobal: UIView!
    @IBOutlet weak var btnPayment: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCouponSelected: UILabel!
    @IBOutlet weak var lblGiftCardSelected: UILabel!
    @IBOutlet weak var lblGiftCard: UILabel!
    @IBOutlet weak var lblCoupon: UILabel!
    @IBOutlet weak var tblMain: UITableView!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var btnCoupon: UIButton!
    @IBOutlet weak var btnGiftCard: UIButton!
    @IBOutlet weak var popUpVw: UIView!
    @IBOutlet weak var btnCross: UIButton!
    @IBOutlet weak var lblGiftCardUser: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblCouponDiscount: UILabel!
    @IBOutlet weak var lblGiftCardBalance: UILabel!
    @IBOutlet weak var tfGiftCardUse: UITextField!
    
    var total_ammount_after_coupon = String()
    var taxAfterPreGiftCard = String()
    var ammoutAfterPreGiftCard = String()
    var withoutCoupon = false
    var arrGiftNew = NSArray()
    var taxAmmount = 0.0
    var coupoun_discount = 0
    var coupon_exp_date = "0000-00-00 00:00:00"
    var selectedIndexpath = IndexPath()
    var CouponSelectedIndexpath = IndexPath()
    var tempSelectedIndexpath = IndexPath()
    var lblTotalPrice:String = ""
    var isGuesUser:Bool = true
    var user_email:String = ""
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var companyuserId:Int = 0
    var companyId:Int = 0
    var customer_id:Int = 0
    var currency:String!
    var email:String = ""
    var isCoupon = true
    var arrCoupon = [CouponCardListModel]()
    var arrGift = [GiftCardDetailsModel]()
    var cart_id:[Int] = [784]
    var giftCardAmmount = String()
    var arrFinalCartIDS = NSArray()
    var actual_price = ""
    var dictPayment:Data!
    var couponId:String = "0" //****
    var giftcard_discount_ammount = "0" //*****
    var dictGift = [String:String]()
    var checkOutString = String()
    var businessSeller = 0
    var isGiftCardApplied = false
    var isSel:Bool! = false
    var isCouponApplied = false
    var global_discount = ""
    var global_discount_percent = ""
    var giftCardId = ""
    var giftCardSeared_id = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let mytoolbar = UIToolbar()
        mytoolbar.sizeToFit()
        let done_btn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(doneBtnAction))
        let myflexible_space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        mytoolbar.setItems([myflexible_space,done_btn], animated: true)
        tfGiftCardUse.inputAccessoryView = mytoolbar
        companyuserId = appDelegate.company_User_Id
        companyId = appDelegate.company_Id
        businessSeller = appDelegate.businessSeller
    
        transparentView.isHidden = true
        popUpVw.isHidden = true
        btnCoupon.isEnabled = true
        btnGiftCard.isEnabled = true
        lblGiftCardSelected.isHidden = true
        lblCouponSelected.isHidden = false
        lblCoupon.textColor = UIColor.gray
        lblGiftCardUser.textColor = UIColor.black
        btnPayment.layer.cornerRadius = 5
        btnPayment.layer.masksToBounds = true
        // Do any additional setup after loading the view.
        self.tblMain.tableFooterView = UIView(frame: CGRect.zero)
        let nib1 = UINib(nibName: "POSCheckOutTableViewCell", bundle: Bundle.main)
        tblMain.register(nib1, forCellReuseIdentifier: "POSCheckOutTableViewCell")
        
        let nib2 = UINib(nibName: "GiftCardTableViewCell", bundle: Bundle.main)
        tblMain.register(nib2, forCellReuseIdentifier: "GiftCardTableViewCell")
        
        let company_currency = appDelegate.currency
        if company_currency == "USD"{
            currency = "$"
        }else{
            currency = "£"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        isGiftCardApplied = false
        selectedIndexpath = IndexPath()
        CouponSelectedIndexpath = IndexPath()
        if businessSeller == 1{
            vwGlobal.isHidden = false
            lblGlobalDiscount.text = global_discount
            lblGDiscount.text = global_discount_percent
        }else{
            vwGlobal.isHidden = true
            
        }
        withoutCoupon = false
        email = UserDefaults.standard.string(forKey: "linkEmail") ?? ""
        lblPrice.text = lblTotalPrice
        lblCouponDiscount.text = currency + "0.0"
        lblGiftCardUser.text = currency + "0.0"
        lblTax.text = currency + String(taxAmmount)
        var token = lblPrice.text!.components(separatedBy: currency)
        if token.count > 0{
            actual_price = token[1]
            
        }
        if isGuesUser {
            getGiftCard(guest:1,email:user_email)
            
        }else{
            let linkEmail = UserDefaults.standard.string(forKey: "linkEmail")!
            getGiftCard(guest:0,email:linkEmail)
        }
       
    }
    
    @IBAction func btnCrossAction(_ sender: Any) {
        
        transparentView.isHidden = true
        popUpVw.isHidden = true
        
        btnCoupon.isEnabled = true
        btnGiftCard.isEnabled = true
        lblGiftCardSelected.isHidden = false
        lblCouponSelected.isHidden = true
        lblCoupon.textColor = UIColor.gray
        lblGiftCardUser.textColor = UIColor.black
      
     //   tblMain.reloadData()
        
    }
    
    @IBAction func couponsAction(_ sender: Any) {
         isCoupon = true
        
        lblCoupon.textColor = UIColor.gray
        lblGiftCardUser.textColor = UIColor.black
        lblCouponSelected.isHidden = false
        lblGiftCardSelected.isHidden = true
         tblMain.reloadData()
    }
    
    @IBAction func giftAction(_ sender: Any) {
        //selectedIndexpath = IndexPath()
        isCoupon = false
        lblGiftCardUser.textColor = UIColor.black
        lblCoupon.textColor = UIColor.black
        lblCouponSelected.isHidden = true
        lblGiftCardSelected.isHidden = false
        isCoupon = false
        tblMain.reloadData()
        
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func paymentAction(_ sender: Any) {
        
        
        if ((arrCoupon.count == 0) && (arrGift.count == 0)) {
            self.withoutCoupon = true
            self.checkoutCalculationApi(coupon_discount:"0",gift_discount:"0")
        }
        else if arrCoupon.count > 0
        {
            if isCouponApplied{
                
                if arrGift.count > 0 {
                    
                    if isGiftCardApplied {
                        
                        makePayment()
                        
                    }else{
                        let alertGift = UIAlertController(title: "Warning", message: "Do you want to proceed without \n gift card?", preferredStyle: UIAlertControllerStyle.alert)
                        alertGift.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (_) in
                            
                           self.makePayment()
                            
                        }))
                        alertGift.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
                        present(alertGift, animated: true, completion: nil)
                    }
                    
                }
                else{ // coupon card is there and applied too but there is no gift card listed
                    makePayment()
                }
               
            }
            else{
                let alert = UIAlertController(title: "Warning", message: "Do you want to proceed without \n coupon?", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (_) in
                    
                    if self.arrGift.count > 0 {
                        
                        if self.isGiftCardApplied {
                            
                            self.makePayment()
                        }
                        else{
                            let alertGift = UIAlertController(title: "Warning", message: "Do you want to proceed \n without gift card?", preferredStyle: UIAlertControllerStyle.alert)
                            alertGift.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (_) in
                                   self.withoutCoupon = true
                                self.checkoutCalculationApi(coupon_discount:"0",gift_discount:"0")
                               // self.makePayment()
                            }))
                            alertGift.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
                            self.present(alertGift, animated: true, completion: nil)
                        }
                        
                    }
                    else{ // coupon is present but not applied and no gift card present
                        self.withoutCoupon = true
                        self.checkoutCalculationApi(coupon_discount:"0",gift_discount:"0")
                    }
                    
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
        else if ((arrCoupon.count == 0) && (arrGift.count > 0)){
            if self.isGiftCardApplied {
                
                self.makePayment()
            }
            else{
                let alertGift = UIAlertController(title: "Warning", message: "Do you want to proceed without gift card?", preferredStyle: UIAlertControllerStyle.alert)
                alertGift.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (_) in
                    self.withoutCoupon = true
                    self.checkoutCalculationApi(coupon_discount:"0",gift_discount:"0")
                    //self.makePayment()
                }))
                alertGift.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alertGift, animated: true, completion: nil)
            }
        }
       
    }
    
    func makePayment() {
        
        //   if arrCoupon.count > 0 {
        if isCoupon {
            
            if dictPayment != nil{
                let nextVC = MakePaymentViewController ()
                var ammount_to_pay = Array<Substring>()
                if currency == "$"
                {
                    ammount_to_pay = lblPrice.text!.split(separator: "$")
                }
                else if currency == "£"
                {
                    ammount_to_pay = lblPrice.text!.split(separator: "£")
                }
                
                nextVC.giftCardId = self.giftCardId
                nextVC.giftCardSeared_id = self.giftCardSeared_id
                nextVC.giftCardAmount = self.giftcard_discount_ammount
                nextVC.couponId = couponId
                nextVC.checkOutData = dictPayment
                nextVC.totalAmount = lblPrice.text!
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
               // alertGuestUser()
            }
        }
        else{
            if dictPayment != nil{
                let nextVC = MakePaymentViewController ()
                nextVC.giftParameters = dictGift
                nextVC.checkOutData = dictPayment
                nextVC.totalAmount = lblPrice.text!
                nextVC.giftCardId = self.giftCardId
                nextVC.giftCardSeared_id = self.giftCardSeared_id
                nextVC.giftCardAmount = self.giftcard_discount_ammount
                self.navigationController?.pushViewController(nextVC, animated: true)
            }else{
               // alertGuestUser()
            }
            
            
        }
        /* }
         else{ ////////////////////////////////// jul 19
         if dictPayment != nil{
         let nextVC = MakePaymentViewController ()
         nextVC.giftParameters = dictGift
         nextVC.checkOutData = dictPayment
         nextVC.totalAmount = lblPrice.text!
         self.navigationController?.pushViewController(nextVC, animated: true)
         }
         }*/
    }
    
    @objc func doneBtnAction()
    {
        view.endEditing(true)
        tfGiftCardUse.resignFirstResponder()
    }
    
    func getGiftCard(guest: Int,email:String){
        
        Alert.addLoader()
        print("arrCartId-----",appDelegate.arrCartId as NSArray)
        
        let request = GiftCardRequest(companyUserId: companyuserId, email: email, cartId: appDelegate.arrCartId as NSArray, guest: guest)
        
        RequestExecutor.executeRequest(request, completion: {(error: Error?, Response: GiftCardListModel?) in
            if Response != nil {
                Alert.removeLoader()
                self.arrCoupon = (Response?.couponList)!
                self.arrGift = (Response?.giftList)!
                self.tblMain.reloadData()
            }
            else{
                Alert.removeLoader()
                let err = error as? DDSError
                let error_Code = err!.description
                print("error_Code====",error_Code)
                Alert.disPlayAlertMessage(titleMessage: "Sorry", alertMsg: error_Code)
            }
        })
    }
    
    @IBAction func applyGiftCardAction(_ sender: Any) {
        let cell = tblMain.cellForRow(at: tempSelectedIndexpath) as! GiftCardTableViewCell
        
        if tfGiftCardUse.text != "" {
            let price:Double = Double(tfGiftCardUse.text!)!
            
            let dblActual_price:Double = Double(actual_price)!
            
            if dblActual_price >= price {
                
                giftcard_discount_ammount = tfGiftCardUse.text!
                selectedIndexpath = tempSelectedIndexpath
                if (selectedIndexpath.row) == cell.imgSelected.tag{
                    
                   // cell.imgSelected.isHidden = false
                    isSel = true
                }else{
                    
                }
                
                checkoutCalculationApi(coupon_discount: couponId, gift_discount:giftcard_discount_ammount)
                //tblMain.reloadData()
            }else{
                 Alert.disPlayAlertMessage(titleMessage: "Sorry", alertMsg: "Giftcard amount should not be greater than payable amount")
             }
        
            
        }
        
    }
    @objc func cellTapAction(sender: UIButton){
        
        let indexpath = IndexPath(row:sender.tag, section: 0)
        
        tempSelectedIndexpath = indexpath
        
        selectedIndexpath = IndexPath()
        tempSelectedIndexpath = IndexPath()
        CouponSelectedIndexpath = IndexPath()
        self.tblMain.reloadData()
        self.isCouponApplied = false
        self.isGiftCardApplied = false
        couponId = ""
        giftcard_discount_ammount = "0"
        giftCardId = ""
        giftCardSeared_id = ""
        //lblGiftCardDiscount.text = currency + "0.0"
    
        tempSelectedIndexpath = indexpath
        isCoupon = true
        //isCouponReset = true
        let dict = arrCoupon[indexpath.row]
        couponId = String(dict.discount)
        checkoutCalculationApi(coupon_discount: couponId, gift_discount: giftcard_discount_ammount)
       
        
    }
    
    func viewCartAmmountApi(delivery_method :String,couponDiscount:String,globalDiscount:String,giftcardDiscount:String,shippingCharge:String)
    {
        Alert.addLoader()
        let request = CheckOutDataRequest(company_user_id: String(companyuserId), company_id: String(companyId), customer_id: String(customer_id), coupon_discount: couponDiscount, global_discount: globalDiscount, giftcard_discount: giftcardDiscount, delivery_method: delivery_method, shipping_charge: shippingCharge)
        RequestExecutor.executeRequest(request, completion: {(error: Error?, Response: CheckOutDataModel?) in
            
            Alert.removeLoader()
            if Response != nil {
                
              
                self.lblPrice.text = self.currency+(Response?.grand_total)!
                self.lblCouponDiscount.text = self.currency+(Response?.coupon_discount)!
                self.lblGiftCardUser.text = self.currency+(Response?.giftcard_usage)!
                self.lblTax.text = self.currency+(Response?.tax)!
                self.lblGlobalDiscount.text = self.currency+(Response?.global_discount)!
                self.lblGDiscount.text = (Response?.global_discount)! + "%"
                /********************/
                self.arrFinalCartIDS = (Response?.final_cart_id_array)!
                self.giftCardAmmount = (Response?.gift_card_amount)!
                
            }
            else{
                
                let err = error as? DDSError
                let error_Code = err!.description
                print("error_Code====",error_Code)
                Alert.disPlayAlertMessage(titleMessage: "Sorry", alertMsg: error_Code)
            }
        })
    }
    
    func checkoutCalculationApi(coupon_discount:String,gift_discount:String)
    {
        Alert.addLoader()
        
        let url = Constants.BASEAPIURL+"calcuate-checkout-data-company"
        let Url = String(format: url)
        guard let serviceUrl = URL(string: Url) else { return }
        let globalDiscount = UserDefaults.standard.string(forKey: "linkDiscount") ?? "0"
        
        let parameterDictionary = ["company_user_id" : companyuserId,"company_id":companyId,"customer_id":customer_id,"coupon_discount": coupon_discount,"global_discount": globalDiscount,"giftcard_discount": gift_discount,"delivery_method": "3","shipping_charge": "0"] as [String : Any]
        print("parameterDictionary ======>>>>>>>",parameterDictionary)
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjQifQ.SOa5o05iLC_Ri-rPZ3aYtKUNWLLBXsRdSd4U1Qt26J4", forHTTPHeaderField: "JWTTOKEN")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                //  print(response)
            }
            if let data = data {
                do {
                    
                    self.dictPayment = data
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                    Alert.removeLoader()
                    
                    print("json body ====>>>", json)
                    let temp = json["result"] as! Bool
                    
                    if temp  {
                       
                        let total = json["grand_total"] as! String
                        let discount = json["product_total_coupon_discount"] as! String
                        let usage = json["gift_card_amount"] as! String
                        let product_total_tax_str = json["product_total_tax"] as! String
                        let product_total_tax = Double(product_total_tax_str)
                        let delivery_tax_str = json["delivery_tax"] as! String
                        let delivery_tax = Double(delivery_tax_str)
                        let global_discount =  json["product_total_global_discount"] as! String
                        print("global_discount---",global_discount)
                        DispatchQueue.main.async {
                            if self.isCoupon == false{
                                self.isGiftCardApplied = true
                            }
                            else{
                                self.isCouponApplied = true
                                self.CouponSelectedIndexpath = self.tempSelectedIndexpath
                                self.total_ammount_after_coupon = self.currency + total
                                self.tblMain.reloadData()
                            }
                            
                            self.popUpVw.isHidden = true
                            self.transparentView.isHidden = true
                            self.lblPrice.text = self.currency + total

                            self.lblCouponDiscount.text = self.currency + discount
                            self.lblGiftCardUser.text = self.currency + usage
                            self.lblTax.text = self.currency + String(product_total_tax! + delivery_tax!)
                            self.lblGlobalDiscount.text = self.currency+global_discount
                            self.tblMain.reloadData()
                            
                            if self.withoutCoupon{
                                if self.dictPayment != nil{
                                    let nextVC = MakePaymentViewController ()
                                    var ammount_to_pay = Array<Substring>()
                                    if self.currency == "$"
                                    {
                                        ammount_to_pay = self.lblPrice.text!.split(separator: "$")
                                    }
                                    else if self.currency == "£"
                                    {
                                        ammount_to_pay = self.lblPrice.text!.split(separator: "£")
                                    }
                                    let ammount_to_pay_str = ammount_to_pay[0]
                                    nextVC.rest_Amount = Double(ammount_to_pay_str) ?? 0.0
                                    nextVC.couponId = self.couponId
                                    nextVC.checkOutData = self.dictPayment
                                    nextVC.totalAmount = self.lblPrice.text!
                                    nextVC.giftCardId = self.giftCardId
                                    nextVC.giftCardSeared_id = self.giftCardSeared_id
                                    nextVC.giftCardAmount = self.giftcard_discount_ammount
                                    self.navigationController?.pushViewController(nextVC, animated: true)
                                }
                            }
                           
                        }
                        
                        
                        
                    }else{
                        let message = json["message"] as! String
                         Alert.disPlayAlertMessage(titleMessage: "Sorry", alertMsg:message)
                        
                    }

                   
                    
                }catch {
                    print(error)
                }
            }
            }.resume()
        
        
        
    }
    func alertGuestUser(){
        
        let al = UIAlertController(title: "Warning!", message: "Do you want to proceed \n with out coupon?", preferredStyle: .alert)
        al.addAction(UIAlertAction(title: "OK", style: .default, handler: {al in
            self.withoutCoupon = true
            self.checkoutCalculationApi(coupon_discount:"0",gift_discount:"0")
        }))
        al.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(al, animated: true, completion: nil)
    }
    
    func goToMakePayment()   {
        
        if isCoupon {
            
            let nextVC = MakePaymentViewController ()
            nextVC.couponId = "0"
            nextVC.checkOutData = dictPayment
            nextVC.totalAmount = lblPrice.text!
            nextVC.giftCardId = self.giftCardId
            nextVC.giftCardSeared_id = self.giftCardSeared_id
            nextVC.giftCardAmount = self.giftcard_discount_ammount
            self.navigationController?.pushViewController(nextVC, animated: true)
            
            
        }else{
            
            dictGift = ["giftcard_amount":"0","giftcard_issue_id":"0","giftcard_seared_id":"0"]
            let nextVC = MakePaymentViewController ()
            nextVC.giftParameters = dictGift
            nextVC.checkOutData = dictPayment
            nextVC.totalAmount = lblPrice.text!
            nextVC.giftCardId = self.giftCardId
            nextVC.giftCardSeared_id = self.giftCardSeared_id
            nextVC.giftCardAmount = self.giftcard_discount_ammount
            self.navigationController?.pushViewController(nextVC, animated: true)
            
    
        }
        
    }
    
    func alertGiftCardChange(){
        
        let alert = UIAlertController(title: "Warning!", message: "Do you want to change giftCard?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (_) in
            
            self.lblPrice.text = self.lblTotalPrice
            if self.isCouponApplied{
                if self.couponId != "" {
                    self.lblPrice.text = self.total_ammount_after_coupon
                }
            }
            
            self.setGiftCardBalance(indexpath: self.tempSelectedIndexpath)
            self.popUpVw.isHidden = false
            self.transparentView.isHidden = false
            self.ammoutAfterPreGiftCard = self.lblTotalPrice
            self.taxAfterPreGiftCard = self.lblTax.text!
            self.lblTax.text = self.currency + String(self.taxAmmount)
            self.lblGiftCardUser.text = self.currency + "0.0"
            self.selectedIndexpath = IndexPath()
            self.tblMain.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (_) in
            /*self.lblPrice.text! = self.ammoutAfterPreGiftCard
            self.lblTax.text! = self.taxAfterPreGiftCard
            self.transparentView.isHidden = true
            self.popUpVw.isHidden = true*/
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isCoupon  {
            return arrCoupon.count
        }else{
            return arrGift.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isCoupon  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "POSCheckOutTableViewCell") as! POSCheckOutTableViewCell
            
            let dict = arrCoupon[indexPath.row]
            print(dict.discount)
            
            coupon_exp_date = dict.coupon_expiry_date
            coupoun_discount = dict.discount
            var strDiscount = String(coupoun_discount)
           cell.btnCouponType.text = dict.alowed_usage
            cell.lblCouponDetails.text = dict.description
            cell.lblCouponName.text = dict.coupon_code + " (" + strDiscount + "% OFF)"
            //"Use this coupon to avail \(String(coupoun_discount))% discount across all products valid till \(coupon_exp_date)."
            cell.imgCoupon.layer.cornerRadius = 5
            cell.btnCellTap.tag = indexPath.row
            cell.btnCellTap.addTarget(self, action: #selector(cellTapAction), for: .touchUpInside)
            
            if indexPath.row % 2 == 0 {
               cell.imgCoupon.image = #imageLiteral(resourceName: "coupon-bg")
            } else {
                cell.imgCoupon.image = #imageLiteral(resourceName: "coupon-bg-red")
            }
            
            if CouponSelectedIndexpath == indexPath {
                cell.imgSeleted.isHidden = false
            }else{
                cell.imgSeleted.isHidden = true
            }
            cell.selectionStyle = .none
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "GiftCardTableViewCell") as! GiftCardTableViewCell
            if indexPath.row % 2 == 0 {
                cell.imgvwGiftBg.image = #imageLiteral(resourceName: "gift-card-even")
            } else {
                cell.imgvwGiftBg.image = #imageLiteral(resourceName: "gift-card-odd")
            }
            let dict = arrGift[indexPath.row]
           
            cell.lblCardNo.text = dict.giftcard_number
            cell.lblDate.text = dict.giftcard_expiry_date
            cell.lblBalance.text = currency + dict.giftcard_amount
            
            cell.btnGiftCard.tag = indexPath.row
            cell.imgSelected.tag = indexPath.row
           // cell.btnGiftCard.addTarget(self, action: #selector(cellTapAction), for: .touchUpInside)
            
            if isGiftCardApplied == true {
                if selectedIndexpath == indexPath {
                cell.imgSelected.isHidden = false
                }
                else{
                cell.imgSelected.isHidden = true
                }
                //cell.imgSelected.isHidden = false
            }else{
                cell.imgSelected.isHidden = true
            }
            cell.selectionStyle = .none
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isCoupon{
            return 90.0
        }else{
            return 170.0
        }
        return 90.0
    }
   
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isCoupon{
            
            let cell = tblMain.cellForRow(at: indexPath) as! POSCheckOutTableViewCell
            if CouponSelectedIndexpath == indexPath {
                cell.imgSeleted.isHidden = true
            }else{
                cell.imgSeleted.isHidden = false
            }
            let dict = arrCoupon[indexPath.row]
             couponId = String(dict.discount)
            
            
        }else{
            
           // let cell = tblMain.cellForRow(at: indexPath) as! GiftCardTableViewCell
            if selectedIndexpath != indexPath{
                
                tempSelectedIndexpath = indexPath
                if isGiftCardApplied{
                    
                    alertGiftCardChange()
                }
                else{
                    self.setGiftCardBalance(indexpath: indexPath)
                    popUpVw.isHidden = false
                    transparentView.isHidden = false
                }
            }
        
        }
    }
    func setGiftCardBalance(indexpath:IndexPath)   {
        
        let dict = arrGift[indexpath.row]
        print(dict.giftcard_amount,dict.giftcard_issue_id!,dict.giftcard_seared_id!)
        
        giftCardId = String(dict.giftcard_issue_id)
        giftCardSeared_id = String(dict.giftcard_seared_id)
        
        dictGift = ["giftcard_amount":dict.giftcard_amount,"giftcard_issue_id":String(dict.giftcard_issue_id!),"giftcard_seared_id":String(dict.giftcard_seared_id!)]
            //var str = ""
        
        var str = ""
         print(lblPrice.text)
        var token = lblPrice.text!.components(separatedBy: currency)
       
        if token.count > 0{
            str = token[1]
            let totalAmount:Double = Double(str)!
            let totalGiftCardAmount:Double = Double(dict.giftcard_amount)!
            
            if totalGiftCardAmount > totalAmount {
                let gift = totalGiftCardAmount-totalAmount
                tfGiftCardUse.text =  String(totalAmount)
                lblGiftCardBalance.text = currency + String(dict.giftcard_amount)
            }else{
                lblGiftCardBalance.text = currency + String(dict.giftcard_amount)
                tfGiftCardUse.text =  String(dict.giftcard_amount)
            }
            
            
        }
        
    }

}

extension POSCheckOutViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if  textField == tfGiftCardUse {
            
            var str = ""
            var str2 = ""
            var giftAmount:Double = 0.0
            var tempAmount = lblGiftCardBalance.text!.components(separatedBy: currency)
            if tempAmount.count > 0{
                str2 = tempAmount[1]
                giftAmount = Double(str2)!
            }
            var token = lblPrice.text!.components(separatedBy: currency)
            if token.count > 0{
                str = token[1]
                let totalAmount:Double = Double(str)!
                let str = (textField.text! + string)
                let price:Double = Double(str)!
                if price <= totalAmount {
                    
                    if price <= giftAmount {
                       return true
                    }else{
                        return false
                    }
                    
                }else{
                   return false
                }
            }
            
           // return false
            
            
        }
        return true
    }
}
