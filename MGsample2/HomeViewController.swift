//
//  HomeViewController.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/06.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

let util = UserUtil()
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
var term = 1

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
        println("button pushed")
        //UIAlertView
        let closure = {
            () -> Void in
            println("this is closure")
            self.periodEndProcess()
        }
        util.alertAppear(self, title: "確認", message: "期末処理は一度行うと取り消しできません。本当に期末処理を行いますか？", cancelTitle: "キャンセル", otherTitle: "はい",closure:closure)
    }
    
    func periodEndProcess() {
        println("period end")
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
        var asset = cashBalance - currentDebt
        var profit = asset - assetOfLastTerm
        if(profit>0){
            println("profit  =\(profit)")
            cashBalance -= profit*40/100
        }
        assetOfLastTerm = cashBalance - currentDebt
        
        let closure = {
            () -> Void in
            println("this is closure")
        }
        util.alertAppear(self, title: "第\(term)期末結果発表", message: "純資産は\(assetOfLastTerm)万円です。\n借入利息は\(currentDebt*interestRate/100)万円です\n固定費(従業員)は\(totalEmployee*80)万円です。\n固定費(シェア)は\(totalShare*10)万円です。\n税引き前利益は\(profit)万円です。\n現金残高は\(cashBalance)万円です", cancelTitle: "OK", otherTitle: "",closure:closure)
        
        
        term += 1
        var multiplier = 1
        if(term>3) {
            multiplier = 3
            interestRate = 5
        } else {
            multiplier = term
        }
        if(assetOfLastTerm > 0) {
            maxDebt = assetOfLastTerm * multiplier
        } else {
            maxDebt = 0
        }
        
        
        cashLabel.text = "現金残高 \(cashBalance)万円"

        
    }
}
