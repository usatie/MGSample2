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
var maxDebt = 3000
var assetOfLastTerm = 3000
var currentDebt = 0
var interestRate = 10

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
    
    @IBAction func jobChangeButtonPushed(sender: AnyObject) {
        performSegueWithIdentifier("segueToJobChange", sender: self)
    }
    
    @IBAction func wildButtonPushed(sender: AnyObject) {
        performSegueWithIdentifier("segueToWild", sender: self)
    }

    @IBAction func changeDepartmentButtonPushed(sender: AnyObject) {
        performSegueWithIdentifier("segueToChange", sender: self)
    }
    
    @IBAction func debtButtonPushed(sender: AnyObject) {
        performSegueWithIdentifier("segueToDebt", sender: self)
        
    }
    
    @IBAction func periodEndButtonPushed(sender: AnyObject) {
        cashBalance -= currentDebt*interestRate/100
        var totalEmployee = 0
        for object:String in jobTypeArray {
            totalEmployee += Array(employeesDic[object]!.values).reduce(0,combine:+)
        }
        var totalShare = Array(numberOfSharesDic.values).reduce(0,combine:+)
        cashBalance -= totalEmployee*80
        cashBalance -= totalShare*10
        println("debt cost = \(currentDebt*interestRate/100)")
        println("Employee cost = \(totalEmployee*80)")
        println("Share cost= \(totalShare*10)")
        cashLabel.text = "現金残高 \(cashBalance)万円"
        var asset = cashBalance - currentDebt
        var profit = asset - assetOfLastTerm
        cashBalance -= profit*40/100
        assetOfLastTerm = cashBalance - currentDebt
    }
}
