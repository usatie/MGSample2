//
//  UserUtil.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/12.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

class UserUtil: NSObject,UIAlertViewDelegate {
    var alertClosure:()->Void = {}
    func alertAppear(vc:UIViewController,title:String,message:String,cancelTitle:String,otherTitle:String,closure:()->Void) {
        if objc_getClass("UIAlertController") != nil {
            //UIAlertController使用
            var ac = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: cancelTitle, style: .Cancel) { (action) -> Void in
                println("Cancel button tapped.")
            }
            
            let okAction = UIAlertAction(title: otherTitle, style: .Default) { (action) -> Void in
                closure()
                println("OK button tapped.")
            }
            
            ac.addAction(cancelAction)
            if otherTitle != "" {
                ac.addAction(okAction)
            }
            
            vc.presentViewController(ac, animated: true, completion: nil)
            
        } else {
            println("it's iOS7.0")
            alertClosure = closure
            let alert = UIAlertView()
            alert.title = title
            alert.message = message
            alert.addButtonWithTitle(cancelTitle)
            if otherTitle != "" {
                alert.addButtonWithTitle(otherTitle)
            }
            alert.delegate = self
            alert.show()
        }
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
            case 0:
                println("Cancel button tapped.")
            case 1:
                println("OK button tapped.")
                alertClosure()
            default:
                break
        }
        
    }
}