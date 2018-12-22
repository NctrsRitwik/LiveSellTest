//
//  BaseTabViewController.swift
//  LiveSell
//
//  Created by Rasmiranjan Sahu on 22/06/18.
//  Copyright © 2018 NCRTS. All rights reserved.
//

import UIKit

class BaseTabViewController: UIViewController, UIGestureRecognizerDelegate {

    var menuView : MenuView?
    
    var arrImageItems = NSArray()
    var arrSelectedImages = NSArray()
    var arrNames = NSArray()
    var isMenu : Bool = false
    var edgePan = UISwipeGestureRecognizer()
    var edgePanClose = UISwipeGestureRecognizer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPanGesture(){
        
        edgePan.direction = .right
        edgePan.delegate = self;
        self.view.addGestureRecognizer(edgePan)
        
        edgePanClose.direction = .left
        edgePanClose.delegate = self;
        self.view.addGestureRecognizer(edgePanClose)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if (gestureRecognizer == edgePan && !isMenu)
        {
            self.openSideMenu()
            isMenu = true;
        }else if (gestureRecognizer == edgePanClose && isMenu)
        {
            self.closeSideMenu()
            isMenu = false;
        }
        return true;
    }
    
    
    func setMenu(){
        
        self.view.endEditing(true)
        
        if menuView == nil{
            
            arrImageItems = ["leftmenu-icon-order.png", "leftmenu-icon-mesage.png", "leftmenu-icon-inventory.png", "leftmenu-icon-pos.png", "leftmenu-icon-settings.png", "leftmenu-icon-help.png", "leftmenu-icon-logout.png"]
            
            arrSelectedImages = ["leftmenu-icon-order-active.png", "leftmenu-icon-mesage-active.png", "leftmenu-icon-inventory-active.png", "leftmenu-icon-pos-active.png", "leftmenu-icon-settings-active.png", "leftmenu-icon-help-active.png", "leftmenu-icon-logout-active.png"]
            
            arrNames = ["Orders", "Messages", "Inventory", "POS", "Settings", "Help", "Logout"]
            
            menuView = MenuView.init(frame: CGRect(x: 0, y: 0, width: 230, height: self.view.frame.size.height))

            menuView?.onClick = {(_ index : Int) -> Void in
                
                self.pushtoViewControlerwithTableid(index: index)
            }
            
            menuView?.onClickBtnMenu = {(_ isSelect : Bool) -> Void in
                
                if isSelect{
                    self.openSideMenu()
                }else{
                    self.closeSideMenu()
                }
            }
            
            menuView?.arrTitle = arrNames
            menuView?.arrImage = arrImageItems
            menuView?.arrSelectedImage = arrSelectedImages
            
            var frame = self.menuView?.frame
            frame?.origin.x = -170
            self.menuView?.frame = frame!

            self.view.addSubview(menuView!)
            
            self.closeSideMenu()
        }
        
//        if (_menuView==nil)
//        {
//            _menuView = [[MenuView alloc]initWithFrame:CGRectMake(0, 0, 80, self.view.frame.size.height)];
//            _menuView.hidden=YES;
//            __typeof(self)weakself=self;
//            _menuView.Onclick=^(int indexRow)
//            {
//                [weakself pushtoViewControlerwithTableid:indexRow];
//                //        [self didCloseMenu:id];
//            };
//            _menuView.arrNames=[[NSArray alloc]initWithArray:arrNames];
//            _menuView.arrImageItems=[[NSArray alloc]initWithArray:arrImageItems];
//            _menuView.arrSelectedImages=[[NSArray alloc]initWithArray:arrSelectedImages];
//
//            [self.view bringSubviewToFront:vwForMenuHover];
//            [self.view addSubview:_menuView];
//            [self HideMenuAnimation];
//
//        }
    }
    
    func pushtoViewControlerwithTableid(index : Int){
        switch index {
        case 0:
            
            UserDefaults.standard.set(index, forKey: kSelectedIndex)
            var isFoundVC = false
            for controller: UIViewController? in navigationController?.viewControllers ?? [UIViewController?]() {
                if (controller is OrdersViewController) {
                    if let aController = controller {
                        navigationController?.popToViewController(aController, animated: false)
                    }
                    isFoundVC = true
                    break
                }
            }
            if !isFoundVC {
                let OrdersViewController = self.storyboard?.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
                self.navigationController?.pushViewController(OrdersViewController, animated: false)
            }
            
        case 1:
            
            UserDefaults.standard.set(index, forKey: kSelectedIndex)
            var isFoundVC = false
            for controller: UIViewController? in navigationController?.viewControllers ?? [UIViewController?]() {
                if (controller is MessageVC) {
                    if let aController = controller {
                        navigationController?.popToViewController(aController, animated: false)
                    }
                    isFoundVC = true
                    break
                }
            }
            if !isFoundVC {
                let MessageVC = self.storyboard?.instantiateViewController(withIdentifier: "MessageVC") as! MessageVC
                self.navigationController?.pushViewController(MessageVC, animated: false)
            }
            
        case 2:
            UserDefaults.standard.set(index, forKey: kSelectedIndex)
            var isFoundVC = false
            for controller: UIViewController? in navigationController?.viewControllers ?? [UIViewController?]() {
                if (controller is AllItemsVC) {
                    if let aController = controller {
                        navigationController?.popToViewController(aController, animated: false)
                    }
                    isFoundVC = true
                    break
                }
            }
            if !isFoundVC {
                let AllItemsVC = self.storyboard?.instantiateViewController(withIdentifier: "AllItemsVC") as! AllItemsVC
                self.navigationController?.pushViewController(AllItemsVC, animated: false)
            }
            
        case 3:
            UserDefaults.standard.set(index, forKey: kSelectedIndex)
            var isFoundVC = false
            for controller: UIViewController? in navigationController?.viewControllers ?? [UIViewController?]() {
                if (controller is POSViewController) {
                    if let aController = controller {
                        navigationController?.popToViewController(aController, animated: false)
                    }
                    isFoundVC = true
                    break
                }
            }
            if !isFoundVC {
                let posVC = self.storyboard?.instantiateViewController(withIdentifier: "POSViewController") as! POSViewController
                self.navigationController?.pushViewController(posVC, animated: false)
            }
            
        case 4:
            UserDefaults.standard.set(index, forKey: kSelectedIndex)
            var isFoundVC = false
            for controller: UIViewController? in navigationController?.viewControllers ?? [UIViewController?]() {
                if (controller is GeneralSettingsVC) {
                    if let aController = controller {
                        navigationController?.popToViewController(aController, animated: false)
                    }
                    isFoundVC = true
                    break
                }
            }
            if !isFoundVC {
                let AllItemsVC = self.storyboard?.instantiateViewController(withIdentifier: "GeneralSettingsVC") as! GeneralSettingsVC
                self.navigationController?.pushViewController(AllItemsVC, animated: false)
            }
            
        default:
            break
        }
    }
    
    func openSideMenu(){
        isMenu = true
        menuView?.isOpen = isMenu
        
        UIView.animate(withDuration: 0.2, animations: {
            
            var frame = self.menuView?.frame
            frame?.origin.x = 0
            self.menuView?.frame = frame!
            
        }) { (completion) in
            self.menuView?.tblMenu.isScrollEnabled = true
            self.menuView?.tblMenu .reloadData()
        }
    }
    
    func closeSideMenu(){
        isMenu = false
        menuView?.isOpen = isMenu
        
        UIView.animate(withDuration: 0.2, animations: {
            
            var frame = self.menuView?.frame
            frame?.origin.x = -170
            self.menuView?.frame = frame!
            
        }) { (completion) in
            self.menuView?.tblMenu.isScrollEnabled = true
            self.menuView?.tblMenu .reloadData()
        }
    }

}
