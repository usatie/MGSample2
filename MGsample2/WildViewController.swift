//
//  WildViewController.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/10.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

class WildViewController: UIViewController {
    var employeeChangeDic = [String:[String:Int]]()
    var shareChangeDic = [String: Int]()
    var market = ""
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        println("hiring")
        loadTemplate()
        var initialMarketDic = ["Search":0,"Local":0, "Entertainment":0, "News":0, "Commerce":0, "SNS":0]
        employeeChangeDic = employeesDic
        shareChangeDic = numberOfSharesDic
        
        for i in 0...3 {
            for j in 0...5 {
                var marketView:MarketView = MarketView(frame: CGRectMake(220 + 180*CGFloat(i), 100+100*CGFloat(j), 180, 100));
                marketView.plusButton.addTarget(self, action:Selector("plusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
                marketView.minusButton.addTarget(self, action:Selector("minusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
                marketView.tag = j+1
                marketView.propertyLabel.hidden = false

                if (i == 3) {
                    //シェアチップについて
                    marketView.type = "Share"
                    view.addSubview(marketView)
                    var share = numberOfSharesDic[marketNameArray[j]]!
                    marketView.propertyLabel.text = "(\(share))"
                    marketView.numberLabel.text = "\(share)"
                    
                } else {
                    //企画、開発、営業について
                    if (i != 2 || j == 0){
                        marketView.type = jobTypeArray[i]//jobTypeArray[i]
                        view.addSubview(marketView)
                        var employee = employeesDic[jobTypeArray[i]]![marketNameArray[j]]!
                        marketView.propertyLabel.text = "(\(employee))"
                        marketView.numberLabel.text = "\(employee)"
                    }
                }

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
        let ChangeView:UIView = UINib(nibName: "WildViewController", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
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
    
//    func shouldChange(jobType: String) -> Bool {
//        return Array(employeesDic[jobType]!.values).reduce(0, combine:+) == Array(employeeChangeDic[jobType]!.values).reduce(0, combine:+)
//    }
    @IBAction func changeButtonPushed(sender: AnyObject) {
        let marketerDiff = abs(Array(employeesDic["Marketer"]!.values).reduce(0, combine:+) - Array(employeeChangeDic["Marketer"]!.values).reduce(0, combine:+))
        
        let engineerDiff = abs(Array(employeesDic["Engineer"]!.values).reduce(0, combine:+) - Array(employeeChangeDic["Engineer"]!.values).reduce(0, combine:+))
        
        //UIAlertView
        let alert:UIAlertController = UIAlertController(title:"確認",
            message: "以下の変更を反映しますか？\n企画：\(marketerDiff)人\n開発：\(engineerDiff)人\nを解雇しようとしています。",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        //Cancel 一つだけしか指定できない
        let cancelAction:UIAlertAction = UIAlertAction(title: "反映せずにホーム画面へ戻る",
            style: UIAlertActionStyle.Destructive,
            handler:{
                (action:UIAlertAction!) -> Void in
                println("Cancel")
                self.dismissViewControllerAnimated(true, completion: nil)
        })
        //default action
        let defaultAction:UIAlertAction = UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                println("OK")1
                //(1)シェア変動
                numberOfSharesDic = self.shareChangeDic
            
                //(2)採用・解雇
                employeesDic = self.employeeChangeDic
                
                self.dismissViewControllerAnimated(true, completion: nil)
        })
        
        let editAction:UIAlertAction = UIAlertAction(title: "修正する", style: UIAlertActionStyle.Default, handler: {
            (action:UIAlertAction!) -> Void in
            println("keep editing")
        })
        
        //AlertもActionSheetも同じ
        alert.addAction(defaultAction)
        alert.addAction(editAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }

}
