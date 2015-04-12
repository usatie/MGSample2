//
//  JobChangeViewController.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/10.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

class JobChangeViewController: UIViewController {

    
    var employeeChangeDic = [String:[String:Int]]()
    var market = ""
    var type = ""
    var theOtherJobType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        println("hiring")
        loadTemplate()
        var initialMarketDic = ["Search":0,"Local":0, "Entertainment":0, "News":0, "Commerce":0, "SNS":0]
        employeeChangeDic = employeesDic
        for i in 0...1 {
            for j in 0...5 {
                var marketView:MarketView = MarketView(frame: CGRectMake(220 + 180*CGFloat(i), 100+100*CGFloat(j), 180, 100));
                marketView.plusButton.addTarget(self, action:Selector("plusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
                marketView.minusButton.addTarget(self, action:Selector("minusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
                marketView.tag = j*2+i+1
                marketView.type = jobTypeArray[i]//jobTypeArray[i]
                view.addSubview(marketView)
                marketView.propertyLabel.hidden = false
                var employee = employeesDic[jobTypeArray[i]]![marketNameArray[j]]!
                marketView.propertyLabel.text = "(\(employee))"
                marketView.numberLabel.text = "\(employee)"
                //name of the market label
                if (i == 0){
                    let nameLabel = UILabel(frame: CGRectMake(20, 100+100*CGFloat(j), 200, 100))
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
        let ChangeView:UIView = UINib(nibName: "JobChangeViewController", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
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
    func canJobChangeWithBool(add:Bool) -> Bool{
        if (add && employeeChangeDic[theOtherJobType]![market] > 0) {
            return true
        } else if (!add && employeeChangeDic[type]![market] > 0){
            return true
        } else {
            return false
        }
    }
    
    
    func minusButtonTapped(sender: AnyObject) {
        var btn: UIButton = sender as! UIButton
        var marketSubview:UIView = btn.superview as UIView!
        var marketView:MarketView = marketSubview.superview as! MarketView
        market = marketNameArray[(marketView.tag-1)/2]
        type = marketView.type
        var theOtherMarketView:MarketView
        if(type == "Marketer") {
            theOtherMarketView = self.view.viewWithTag(marketView.tag+1) as! MarketView
            theOtherJobType = "Engineer"
        } else {
            theOtherMarketView = self.view.viewWithTag(marketView.tag-1) as! MarketView
            theOtherJobType = "Marketer"
        }
        if(canJobChangeWithBool(false)){
            println("\(market) hired less")
            employeeChangeDic[type]![market] = employeeChangeDic[type]![market]! - 1
            marketView.numberLabel.text = "\(employeeChangeDic[type]![market]!)"
            employeeChangeDic[theOtherJobType]![market] = employeeChangeDic[theOtherJobType]![market]! + 1
            theOtherMarketView.numberLabel.text = "\(employeeChangeDic[theOtherJobType]![market]!)"
        }
    }
    func plusButtonTapped(sender: AnyObject) {
        var btn: UIButton = sender as! UIButton
        var marketSubview:UIView = btn.superview as UIView!
        var marketView:MarketView = marketSubview.superview as! MarketView
        market = marketNameArray[(marketView.tag-1)/2]
        type = marketView.type
        var theOtherMarketView:MarketView
        if(type == "Marketer") {
            theOtherMarketView = self.view.viewWithTag(marketView.tag+1) as! MarketView
            theOtherJobType = "Engineer"
        } else {
            theOtherMarketView = self.view.viewWithTag(marketView.tag-1) as! MarketView
            theOtherJobType = "Marketer"
        }
        if(canJobChangeWithBool(true)){
            println("\(market) hired more")
            employeeChangeDic[type]![market] = employeeChangeDic[type]![market]! + 1
            marketView.numberLabel.text = "\(employeeChangeDic[type]![market]!)"
            employeeChangeDic[theOtherJobType]![market] = employeeChangeDic[theOtherJobType]![market]! - 1
            theOtherMarketView.numberLabel.text = "\(employeeChangeDic[theOtherJobType]![market]!)"
        }
    }
    func getDiff(jobType: String) -> Int {
        var sum = 0
        for object:String in marketNameArray {
            sum += abs(employeesDic[jobType]![object]! - employeeChangeDic[jobType]![object]!)
        }
        return sum/2
    }
    
    @IBAction func changeButtonPushed(sender: AnyObject) {
        var diff = 0
        for object:String in marketNameArray {
            diff += abs(employeeChangeDic["Marketer"]![object]! - employeesDic["Marketer"]![object]!)
        }
        
        if (isNotEmployeeChanged()){
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            let closure = {
                () -> Void in
                println("this is closure")
                println("ok")
                println("job changed people = \(diff)")
                cashBalance -= diff*5
                employeesDic = self.employeeChangeDic
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            util.alertAppear(self, title: "確認", message: "職種を変更します。", cancelTitle: "キャンセル", otherTitle: "OK", closure: closure)
        }
    }
    
    @IBAction func cancelButtonPushed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func isNotEmployeeChanged() -> Bool {
        var ifChanged = true
        for object:String in jobTypeArray {
            if(employeeChangeDic[object]! != employeesDic[object]!){
                ifChanged = false
            }
        }
        return ifChanged
    }
}
