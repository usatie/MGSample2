//
//  WildViewController.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/10.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

class WildViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    var employeeChangedDic = [String:[String:Int]]()
    var shareChangeDic = [String: Int]()
    var market = ""
    var type = ""
    @IBOutlet var cashBalancePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        println("hiring")
        loadTemplate()
        var initialMarketDic = ["Search":0,"Local":0, "Entertainment":0, "News":0, "Commerce":0, "SNS":0]
        employeeChangedDic = employeesDic
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
                        marketView.type = jobTypeArray[i]
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
        let WildView:UIView = UINib(nibName: "WildViewController", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        view = WildView
    }
    
    //Check the action's availability
    func canDeduct() -> Bool {
        if(employeeChangedDic[type]![market] > 0){ return true}
        else {return false}
    }
    
    func canAdd() -> Bool {
        let sum = getDiff("Marketer") + getDiff("Engineer")
        if(cashBalance > sum*5/* && Array(employeesDic[type]!.values).reduce(0, combine:+) > Array(employeeChangedDic[type]!.values).reduce(0, combine:+)*/) {return true}
        else {return false}
    }
    
    
    func minusButtonTapped(sender: AnyObject) {
        var btn: UIButton = sender as! UIButton
        var marketSubview:UIView = btn.superview as UIView!
        var marketView:MarketView = marketSubview.superview as! MarketView
        market = marketNameArray[marketView.tag-1]
        type = marketView.type
        if(type == "Share"){
            shareChangeDic[market] = shareChangeDic[market]! - 1
            marketView.numberLabel.text = "\(shareChangeDic[market]!)"
        } else {
            if(canDeduct()){
                println("\(market) hired less")
                employeeChangedDic[type]![market] = employeeChangedDic[type]![market]! - 1
                marketView.numberLabel.text = "\(employeeChangedDic[type]![market]!)"
            }
        }
    }
    func plusButtonTapped(sender: AnyObject) {
        var btn: UIButton = sender as! UIButton
        var marketSubview:UIView = btn.superview as UIView!
        var marketView:MarketView = marketSubview.superview as! MarketView
        market = marketNameArray[marketView.tag-1]
        type = marketView.type
        if(type == "Share"){
            shareChangeDic[market] = shareChangeDic[market]! + 1
            marketView.numberLabel.text = "\(shareChangeDic[market]!)"
        } else {
            if (canAdd()) {
                println("\(market) hired more")
                employeeChangedDic[type]![market] = employeeChangedDic[type]![market]! + 1
                marketView.numberLabel.text = "\(employeeChangedDic[type]![market]!)"
            }
        }
    }
    func getDiff(jobType: String) -> Int {
        var sum = 0
        for object:String in marketNameArray {
            sum += abs(employeesDic[jobType]![object]! - employeeChangedDic[jobType]![object]!)
        }
        return sum/2
    }
    
    @IBAction func changeButtonPushed(sender: AnyObject) {
        let marketerDiff = abs(Array(employeesDic["Marketer"]!.values).reduce(0, combine:+) - Array(employeeChangedDic["Marketer"]!.values).reduce(0, combine:+))
        let engineerDiff = abs(Array(employeesDic["Engineer"]!.values).reduce(0, combine:+) - Array(employeeChangedDic["Engineer"]!.values).reduce(0, combine:+))
        let salesDiff = abs(Array(employeesDic["Sales"]!.values).reduce(0, combine:+) - Array(employeeChangedDic["Sales"]!.values).reduce(0, combine:+))
        
        let shareDiff = Array(shareChangeDic.values).reduce(0, combine:+) - Array(numberOfSharesDic.values).reduce(0, combine:+)
        //UIAlertView
        let employeeStr = "企画：\(marketerDiff)人\n開発：\(engineerDiff)人\n営業：\(salesDiff)人\nを解雇しようとしています。\n"
        let shareStr = "シェア：\(shareDiff)\nを獲得（喪失）しようとしています。\n"
        var alertStr = "以下の変更を反映しますか？\n"
        
        if (!isNotEmployeeChanged() && shareChangeDic != numberOfSharesDic) {
            alertStr += employeeStr + shareStr
        } else if (isNotEmployeeChanged() && shareChangeDic != numberOfSharesDic) {
            alertStr += shareStr
        } else if (!isNotEmployeeChanged() && shareChangeDic == numberOfSharesDic) {
            alertStr += employeeStr
        } else {
            //変更が何もなければホームへ戻る
            dismissViewControllerAnimated(true, completion: nil)
            return
        }
        let closure = {
            () -> Void in
            println("this is closure")
            //(1)シェア変動
            numberOfSharesDic = self.shareChangeDic
            
            //(2)採用・解雇
            employeesDic = self.employeeChangedDic
            
            //(3)cashBalance (M&A用)
            cashBalance -= self.cashBalancePickerView.selectedRowInComponent(0)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        util.alertAppear(self, title: "確認", message: alertStr, cancelTitle: "キャンセル", otherTitle: "OK", closure: closure)

    }
    @IBAction func cancelButtonPushed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func isNotEmployeeChanged() -> Bool {
        var ifChanged = true
        for object:String in jobTypeArray {
            if(employeeChangedDic[object]! != employeesDic[object]!){
                ifChanged = false
            }
        }
        return ifChanged
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cashBalance+1
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(row)万円"
    }
}
