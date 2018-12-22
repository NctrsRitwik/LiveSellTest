//
//  Common.swift
//  LEA
//
//  Created by Poojashree on 9/8/17.
//  Copyright © 2017 NCR Technosolutions. All rights reserved.
//

import UIKit
import SystemConfiguration
//import NVActivityIndicatorView
//import Reachability

let baseURL : String = ""

//var config = SwiftLoader.Config()

let strDeviceID : String = (UIDevice.current.identifierForVendor?.uuidString)!

let kUserRequestKey = "User Request Key"

let kUserID                 = "UserID"
let kDeviceID               = "kDeviceID"
let kUserEmail              = "UserEmail"
let kUserPass               = "UserPass"
let kisLogin                = "kisLogin"
let kisRemember             = "kisRemember"
let kErrorOccured: String   = "Some error occured. Please try again later."
let kNoInternet: String     = "Please check your internet connection and try again."
let kSelectedIndex: String  = "kSelectedIndex"

class Common: NSObject {

    
    //MARK:- Show Alert View
    
    class func showAlert (message:String?, title:String?,viewController:UIViewController){
        
        let alert = UIAlertController(title: "LiveSell",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .default, handler: nil)
        
        alert.addAction(cancelAction)
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK:- Check Internet Connection
    
//    class func connectedToNetwork() -> Bool {
//
////        var zeroAddress = sockaddr_in()
////        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
////        zeroAddress.sin_family = sa_family_t(AF_INET)
////
////
////        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
////            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
////                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
////            }
////        }
////
////        var flags : SCNetworkReachabilityFlags = []
////        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
////            return false
////        }
////
////        let isReachable = flags.contains(.reachable)
////        let needsConnection = flags.contains(.connectionRequired)
////
////        return (isReachable && !needsConnection)
//
//        let reachability = Reachability()!
//
//        if (reachability.allowsCellularConnection){
//
//            return true
//        }else{
//
//            return false
//        }
//
//
////        reachability.whenReachable = { reachability in
////            if reachability.connection == .wifi {
////                print("Reachable via WiFi")
////            } else {
////                print("Reachable via Cellular")
////            }
////
////            return true
////        }
////        reachability.whenUnreachable = { _ in
////            print("Not reachable")
////
////            return false
////
////        }
//
//
//    }

    //MARK:- Show Toast Message

//    class func showToast (message:String?){
//
//        let toastLabel = UILabel(frame: CGRect(x: APP_DELEGATE.window!.bounds.width/2 - 150, y: APP_DELEGATE.window!.bounds.height/2-20, width: 300, height: 40))
//        let bgLabel = UILabel(frame: CGRect(x: 0, y:0, width: APP_DELEGATE.window!.bounds.width, height: APP_DELEGATE.window!.bounds.height))
//
//        let fullName    = message
//        let fullArr = fullName?.components(separatedBy: ".")
//
//
//        toastLabel.text = fullArr?[0]
//
//        toastLabel.numberOfLines = 0
//        let maximumLabelSize = CGSize(width: CGFloat(toastLabel.frame.size.width), height: CGFloat(Float.greatestFiniteMagnitude))
//        let expectedLabelSize: CGRect = message!.boundingRect(with: maximumLabelSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: toastLabel.font], context: nil)
//        //adjust the label the the new height.
//
//        var newFrame: CGRect = toastLabel.frame
//
//        if  expectedLabelSize.size.height > 40 {
//            newFrame.size.height = expectedLabelSize.size.height
//        }
//
//        toastLabel.frame = newFrame
//
//        bgLabel.backgroundColor = UIColor.black.withAlphaComponent(0.2)
//        toastLabel.backgroundColor = UIColor(red: 63/255, green: 149/255, blue: 141/255, alpha: 1).withAlphaComponent(0.6)
//        toastLabel.textColor = UIColor.white
//        toastLabel.textAlignment = .center;
//        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
//
//        toastLabel.layer.cornerRadius = 10;
//        toastLabel.clipsToBounds  =  true
//        toastLabel.alpha = 0.0
//        bgLabel.alpha = 0.0
//
//        if let window = APP_DELEGATE.window{
//
//            window.addSubview(toastLabel)
//            window.addSubview(bgLabel)
//            window.bringSubview(toFront: bgLabel)
//        }
//
//        UIView.animate(withDuration: 0.5, delay:0.1, options: .curveEaseIn, animations: {
//            toastLabel.alpha = 1.0
//            bgLabel.alpha = 1.0
//        }, completion: {(isCompleted) in
//            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
//                toastLabel.alpha = 0.0
//                bgLabel.alpha = 0.0
//            }, completion: {(isCompleted) in
//                toastLabel.removeFromSuperview()
//                bgLabel.removeFromSuperview()
//            })
//        })
//    }
    
//    class func addLoader() {
//
//        let activityData = ActivityData()
//        NVActivityIndicatorView.DEFAULT_TYPE = .ballClipRotateMultiple
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
//            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
//        }
//    }
//
//    class func removeLoader(){
//
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
//
//            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
//        }
//    }
    
    class func convertDateTime(from strDate: String, fromFormate strFromFormate: String, toFormate strNewFormate: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = strFromFormate
        let date: Date? = dateFormat.date(from: strDate)
        dateFormat.dateFormat = strNewFormate
        let output: String = dateFormat.string(from: date!)
        return output
    }
}


