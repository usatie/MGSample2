//
//  HomeViewController.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/06.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

var cashBalance = 300
var marketNameArray = ["Search","Local", "Entertainment", "News", "Commerce", "SNS"]
var numberOfEmployeesDic = [String:Int]()

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        numberOfEmployeesDic = ["Search":0,"Local":0, "Entertainment":0, "News":0, "Commerce":0, "SNS":0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        println("cashBalance = \(cashBalance)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
