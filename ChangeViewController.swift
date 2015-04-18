//
//  ChangeViewController.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/09.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

class ChangeViewController: UIViewController {

    var employeeChangeDic = [String:[String:Int]]()
    var market = ""
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        println("hiring")
        loadTemplate()
        var initialMarketDic = ["Search":0,"Local":0, "Entertainment":0, "News":0, "Commerce":0, "SNS":0]
        employeeChangeDic = ["Marketer":employeesDic["Marketer"]!,"Engineer":employeesDic["Engineer"]!]
        for i in 0...1 {
            for j in 0...5 {
                var marketView:MarketView = MarketView(frame: CGRectMake(220 + 180*CGFloat(i), 100+100*CGFloat(j), 180, 100));
                marketView.plusButton.addTarget(self, action:Selector("plusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
                marketView.minusButton.addTarget(self, action:Selector("minusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
                marketView.tag = j+1
                marketView.type = jobTypeArray[i]//jobTypeArray[i]
                view.addSubview(marketView)
                marketView.propertyLabel.hidden = false
                var employee = employeesDic[jobTypeArray[i]]![marketNameArray[j]]!
                marketView.propertyLabel.text = "(\(employee))"
                marketView.numberLabel.text = "\(employee)"
                //name of the market label
                if (i == 0){
                    let nameLabel = UILabel(frame: CGRectMake(20, 100+100*CGFloat(j)-16, 200, 100))
                    nameLabel.text = "\(marketNameArray[j])"
                    view.addSubview(nameLabel)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //load xib file
    func loadTemplate(){
        let ChangeView:UIView = UINib(nibName: "ChangeViewController", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        view = ChangeView
    }
    
    //Check the action's availability
    func canDeduct() -> Bool {
        if(employeeChangeDic[type]![market] > 0){ return true}
        else {return false}
    }
    
    func canAdd() -> Bool {
        let sum = getDiff("Marketer") + getDiff("Engineer")
        if(cashBalance > sum*5 && Array(employeesDic[type]!.values).reduce(0, combine:+) > Array(employeeChangeDic[type]!.values).reduce(0, combine:+)) {return true}
        else {return false}
    }
    
    
    func minusButtonTapped(sender: AnyObject) {
        var btn: UIButton = sender as! UIButton
        var marketSubview:UIView = btn.superview as UIView!
        var marketView:MarketView = marketSubview.superview as! MarketView
        market = marketNameArray[marketView.tag-1]
        type = marketView.type
        if(canDeduct()){
            println("\(market) hired less")
            employeeChangeDic[type]![market] = employeeChangeDic[type]![market]! - 1
            marketView.numberLabel.text = "\(employeeChangeDic[type]![market]!)"
        }
    }
    func plusButtonTapped(sender: AnyObject) {
        var btn: UIButton = sender as! UIButton
        var marketSubview:UIView = btn.superview as UIView!
        var marketView:MarketView = marketSubview.superview as! MarketView
        market = marketNameArray[marketView.tag-1]
        type = marketView.type
        if (canAdd()) {
            println("\(market) hired more")
            employeeChangeDic[type]![market] = employeeChangeDic[type]![market]! + 1
            marketView.numberLabel.text = "\(employeeChangeDic[type]![market]!)"
        }
    }
    func getDiff(jobType: String) -> Int {
        var sum = 0
        for object:String in marketNameArray {
            sum += abs(employeesDic[jobType]![object]! - employeeChangeDic[jobType]![object]!)
        }
        return sum/2
    }
    
    func shouldChange(jobType: String) -> Bool {
        return Array(employeesDic[jobType]!.values).reduce(0, combine:+) == Array(employeeChangeDic[jobType]!.values).reduce(0, combine:+)
    }
    @IBAction func changeButtonPushed(sender: AnyObject) {
        let marketerDiff = abs(Array(employeesDic["Marketer"]!.values).reduce(0, combine:+) - Array(employeeChangeDic["Marketer"]!.values).reduce(0, combine:+))

        let engineerDiff = abs(Array(employeesDic["Engineer"]!.values).reduce(0, combine:+) - Array(employeeChangeDic["Engineer"]!.values).reduce(0, combine:+))

        if(shouldChange("Marketer") && shouldChange("Engineer")) {
            println("\(cashBalance) before")
            cashBalance -= getDiff("Marketer")*5 + getDiff("Engineer")*5
            println("\(cashBalance) after")
            for object : String in marketNameArray{
                for jobType in jobTypeArray {
                    if jobType != "Sales"{
                        employeesDic[jobType]![object] = employeeChangeDic[jobType]![object]!
                        var employee = employeesDic[jobType]![object]!
                        println("\(object) \(jobType) = \(employee)")
                    }
                }
            }
            
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            println("Cannot dismiss any employees")
            
            let closure = {
                () -> Void in
                println("this is closure")
            }
            util.alertAppear(self, title: "解雇できません", message: "社員は解雇できません。全員どこかのサービスに振り分けてあげてください。\n企画：あと\(marketerDiff)人\n開発：あと\(engineerDiff)人", cancelTitle: "OK", otherTitle: "", closure: closure)
        }
        
    }

    @IBAction func cancelButtonPushed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
