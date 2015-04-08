//
//  P&DViewController.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/06.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

class P_DViewController: UIViewController {
    var numberPlannedDic = [String:Int]()
    var numberDevelopedDic = [String:Int]()
    var market = ""
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.loadTemplate()
        numberPlannedDic = ["Search":0,"Local":0, "Entertainment":0, "News":0, "Commerce":0, "SNS":0]
        numberDevelopedDic = ["Search":0,"Local":0, "Entertainment":0, "News":0, "Commerce":0, "SNS":0]
        
        for i in 0...5 {
            var marketView:MarketView = MarketView(frame: CGRectMake(200, 100+100*CGFloat(i), 180, 100));
            var employee = employeesDic["Marketer"]![marketNameArray[i]]!
            marketView.plusButton.addTarget(self, action:Selector("plusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
            marketView.minusButton.addTarget(self, action:Selector("minusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
            marketView.tag = i+1
            marketView.type = "plan"
            self.view.addSubview(marketView)
            var marketer = employeesDic[jobTypeArray[0]]![marketNameArray[i]]!
            var engineer = employeesDic[jobTypeArray[1]]![marketNameArray[i]]!
            var sales = employeesDic[jobTypeArray[2]]![marketNameArray[i]]!
            var plan = numberOfPlansDic[marketNameArray[i]]!
            var product = numberOfProductsDic[marketNameArray[i]]!
            let nameLabel = UILabel(frame: CGRectMake(20, 100+100*CGFloat(i), 200, 100))
            nameLabel.text = "\(marketNameArray[i]) (\(marketer))(\(engineer))"
            self.view.addSubview(nameLabel)
            marketView.propertyLabel.hidden = false
            marketView.propertyLabel.text = "(\(plan))"
        }
        for i in 0...5 {
            var marketView:MarketView = MarketView(frame: CGRectMake(380, 100+100*CGFloat(i), 180, 100));
            marketView.plusButton.addTarget(self, action:Selector("plusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
            marketView.minusButton.addTarget(self, action:Selector("minusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
            marketView.tag = i+1
            marketView.type = "product"
            self.view.addSubview(marketView)
            var product = numberOfProductsDic[marketNameArray[i]]!
            marketView.propertyLabel.hidden = false
            marketView.propertyLabel.text = "(\(product))"
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //load xib file
    func loadTemplate(){
        let view:UIView = UINib(nibName: "P&DViewController", bundle: nil).instantiateWithOwner(self, options: nil)[0] as UIView
        self.view = view
    }
    
    //Check the action's availability
    func canDeduct() -> Bool {
        if(type == "plan"){
            if(numberPlannedDic[market] > 0){ return true}
            else {return false}
        } else if (type == "product") {
            if(numberDevelopedDic[market] > 0){ return true}
            else {return false}
        } else {return false}
    }
    
    func canAdd() -> Bool {
        let sum = Array(numberPlannedDic.values).reduce(0, +) + Array(numberDevelopedDic.values).reduce(0, +)
        switch type {
            case "plan":
                var marketer = employeesDic["Marketer"]![market]!
                if(marketer>numberPlannedDic[market] && cashBalance>sum*10) {return true}
                else {return false}
            case "product":
                var engineer = employeesDic["Engineer"]![market]!
                if(numberOfPlansDic[market]>numberDevelopedDic[market] && engineer>numberDevelopedDic[market] && cashBalance>sum*10) {return true}
                else {return false}
            default:
                return false
            
        }
    }
    
    func minusButtonTapped(sender: AnyObject) {
        var btn: UIButton = sender as UIButton
        var marketSubview:UIView = btn.superview as UIView!
        var marketView:MarketView = marketSubview.superview as MarketView
        market = marketNameArray[marketView.tag-1]
        type = marketView.type
        if(self.canDeduct()){
            if(type == "plan") {
                println("\(market) planned less")
                numberPlannedDic[market] = numberPlannedDic[market]! - 1
                marketView.numberLabel.text = "\(numberPlannedDic[market]!)"
            } else if (type == "product") {
                println("\(market) developed less")
                numberDevelopedDic[market] = numberDevelopedDic[market]! - 1
                marketView.numberLabel.text = "\(numberDevelopedDic[market]!)"
            }
        }
    }
    func plusButtonTapped(sender: AnyObject) {
        var btn: UIButton = sender as UIButton
        var marketSubview:UIView = btn.superview as UIView!
        var marketView:MarketView = marketSubview.superview as MarketView
        market = marketNameArray[marketView.tag-1]
        type = marketView.type
        if (self.canAdd()) {
            if(type == "plan") {
                println("\(market) planned less")
                numberPlannedDic[market] = numberPlannedDic[market]! + 1
                marketView.numberLabel.text = "\(numberPlannedDic[market]!)"
            } else if (type == "product") {
                println("\(market) developed less")
                numberDevelopedDic[market] = numberDevelopedDic[market]! + 1
                marketView.numberLabel.text = "\(numberDevelopedDic[market]!)"
            }
        }
    }
    @IBAction func completeButtonPushed(sender: AnyObject) {
        for object : String in marketNameArray{
            cashBalance -= numberPlannedDic[object]!*10 + numberDevelopedDic[object]!*10
            numberOfPlansDic[object] = numberOfPlansDic[object]! + numberPlannedDic[object]! - numberDevelopedDic[object]!
            numberOfProductsDic[object] = numberOfProductsDic[object]! + numberDevelopedDic[object]!
            println("\(object) plan = \(numberOfPlansDic[object]!)\ndeveloped = \(numberOfProductsDic[object]!)")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
