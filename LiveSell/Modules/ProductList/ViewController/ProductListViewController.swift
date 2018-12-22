//
//  ProductListListViewController.swift
//  LiveSell
//
//  Created by Aradhana Ray on 08/06/18.
//  Copyright © 2018 Aradhana Ray. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var tblMain: UITableView!
    var arrProduct = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblMain.tableFooterView = UIView(frame: CGRect.zero)
        let nibName = UINib(nibName: "ProductListTableViewCell", bundle:Bundle.main)
        tblMain.register(nibName, forCellReuseIdentifier: "ProductListTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    @IBAction func btnLeftMenuAction(_ sender: Any) {
        slideMenuController()?.toggleLeft()
        print("slide Menu click")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mycell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell", for: indexPath) as! ProductListTableViewCell
       
      //  mycell.lblProductName.text = arrProduct[indexPath.row]
        
       // mycell.imgProduct.image = UIImage(named: arrProduct[indexPath.row])
        return mycell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116.0
    }
}
