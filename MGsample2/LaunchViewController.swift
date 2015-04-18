//
//  LaunchViewController.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/06.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    var numberLaunchedDic = [String:Int]()
    var market = ""
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loadTemplate()
        numberLaunchedDic = ["Search":0,"Local":0, "Entertainment":0, "News":0, "Commerce":0, "SNS":0]
        
        for i in 0...5 {
            var marketView:MarketView = MarketView(frame: CGRectMake(200, 100+100*CGFloat(i), 180, 100));
            var employee = employeesDic["Marketer"]![marketNameArray[i]]!
            marketView.plusButton.addTarget(self, action:Selector("plusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
            marketView.minusButton.addTarget(self, action:Selector("minusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
            marketView.tag = i+1
            marketView.type = "plan"
            view.addSubview(marketView)
            var marketer = employeesDic[jobTypeArray[0]]![marketNameArray[i]]!
            var engineer = employeesDic[jobTypeArray[1]]![marketNameArray[i]]!
            var sales = employeesDic[jobTypeArray[2]]![marketNameArray[i]]!
            var plan = numberOfPlansDic[marketNameArray[i]]!
            var product = numberOfProductsDic[marketNameArray[i]]!
            let nameLabel = UILabel(frame: CGRectMake(20, 100+100*CGFloat(i)-16, 200, 100))
            nameLabel.text = "\(marketNameArray[i])"
            view.addSubview(nameLabel)
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
        let LaunchView:UIView = UINib(nibName: "LaunchViewController", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        view = LaunchView
    }
    
    //Check the action's availability
    func canDeduct() -> Bool {
        if(numberLaunchedDic[market] > 0){ return true}
        else {return false}
    }
    
    func canAdd() -> Bool {
        let sum = Array(numberLaunchedDic.values).reduce(0, combine:+)
        var share = numberOfProductsDic[market]!
        if(share>numberLaunchedDic[market] && cashBalance>sum*10) {return true}
        else {return false}

    }
    
    func minusButtonTapped(sender: AnyObject) {
        var btn: UIButton = sender as! UIButton
        var marketSubview:UIView = btn.superview as UIView!
        var marketView:MarketView = marketSubview.superview as! MarketView
        market = marketNameArray[marketView.tag-1]
        type = marketView.type
        if(canDeduct()){
            println("\(market) Launched less")
            numberLaunchedDic[market] = numberLaunchedDic[market]! - 1
            marketView.numberLabel.text = "\(numberLaunchedDic[market]!)"
        }
    }
    func plusButtonTapped(sender: AnyObject) {
        var btn: UIButton = sender as! UIButton
        var marketSubview:UIView = btn.superview as UIView!
        var marketView:MarketView = marketSubview.superview as! MarketView
        market = marketNameArray[marketView.tag-1]
        type = marketView.type
        if (canAdd()) {
            println("\(market) Launched less")
            numberLaunchedDic[market] = numberLaunchedDic[market]! + 1
            marketView.numberLabel.text = "\(numberLaunchedDic[market]!)"
        }
    }
    @IBAction func completeButtonPushed(sender: AnyObject) {
        for object : String in marketNameArray{
            cashBalance -= numberLaunchedDic[object]!*10
            numberOfProductsDic[object] = numberOfProductsDic[object]! - numberLaunchedDic[object]!
            numberOfSharesDic[object] = numberOfSharesDic[object]! + numberLaunchedDic[object]!
            println("\(object) share = \(numberOfSharesDic[object]!)")
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func cancelButtonPushed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
