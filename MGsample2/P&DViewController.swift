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
            var marketView:MarketView = MarketView(frame: CGRectMake(20, 60+100*CGFloat(i), 402, 60));
            marketView.nameLabel.text = marketNameArray[i] + "(\(numberOfEmployeesDic[marketNameArray[i]]!))"
            marketView.plusButton.addTarget(self, action:Selector("plusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
            marketView.minusButton.addTarget(self, action:Selector("minusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
            marketView.tag = i+1
            marketView.type = "plan"
            self.view.addSubview(marketView)
        }
        for i in 0...5 {
            var marketView:MarketView = MarketView(frame: CGRectMake(422, 60+100*CGFloat(i), 402, 60));
            marketView.nameLabel.hidden = true
            marketView.plusButton.addTarget(self, action:Selector("plusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
            marketView.minusButton.addTarget(self, action:Selector("minusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
            marketView.tag = i+1
            marketView.type = "product"
            self.view.addSubview(marketView)
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
                if(numberOfEmployeesDic[market]>numberPlannedDic[market] && cashBalance>sum*10) {return true}
                else {return false}
            case "product":
                if(numberOfPlansDic[market]>numberDevelopedDic[market] && numberOfEmployeesDic[market]>numberDevelopedDic[market] && cashBalance>sum*10) {return true}
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
