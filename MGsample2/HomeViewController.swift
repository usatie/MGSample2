//
//  HomeViewController.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/06.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

var cashBalance = 3000
let marketNameArray = ["Search","Local", "Entertainment", "News", "Commerce", "SNS"]
let jobTypeArray = ["Marketer","Engineer","Sales"]
var employeesDic = [String:[String:Int]]()
//var numberOfEmployeesDic = [String:Int]()
var numberOfPlansDic = [String:Int]()
var numberOfProductsDic = [String:Int]()
var numberOfSharesDic = [String:Int]()

class HomeViewController: UIViewController {
    @IBOutlet var cashLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadTemplate()
        var initialMarketDic = ["Search":0,"Local":0, "Entertainment":0, "News":0, "Commerce":0, "SNS":0]
        employeesDic = ["Marketer":initialMarketDic,"Engineer":initialMarketDic,"Sales":initialMarketDic]
        numberOfPlansDic = initialMarketDic
        numberOfProductsDic = initialMarketDic
        numberOfSharesDic = initialMarketDic
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        println("cashBalance = \(cashBalance)")
        cashLabel.text = "現金残高 \(cashBalance)万円"
    }

    
    func loadTemplate(){
        let HomeView:UIView = UINib(nibName: "HomeViewController", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        view = HomeView
    }
    @IBAction func hireButtonPushed(sender: AnyObject) {
        performSegueWithIdentifier("segueToHire", sender: self)
    }
    
    @IBAction func pdButtonPushed(sender: AnyObject) {
        performSegueWithIdentifier("segueToP&D", sender: self)
    }

    @IBAction func launchButtonPushed(sender: AnyObject) {
        performSegueWithIdentifier("segueToLaunch", sender: self)
    }

    @IBAction func acquireButtonPushed(sender: AnyObject) {
        performSegueWithIdentifier("segueToAcquisition", sender: self)
    }
    
    @IBAction func changeDepartmentButtonPushed(sender: AnyObject) {
        performSegueWithIdentifier("segueToChange", sender: self)
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
