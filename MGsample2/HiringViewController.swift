//
//  HiringViewController.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/06.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

class HiringViewController: UIViewController {

    @IBOutlet var searchLabel: UILabel!
    var numberHiredDic = [String:Int]()
    var market = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("hiring")
        self.loadTemplate()
        numberHiredDic = ["Search":0,"Local":0, "Entertainment":0, "News":0, "Commerce":0, "SNS":0]
        
        for i in 0...5 {
            var marketView:MarketView = MarketView(frame: CGRectMake(20, 60+100*CGFloat(i), 640, 60));
            marketView.nameLabel.text = marketNameArray[i] + "(\(numberOfEmployeesDic[marketNameArray[i]]!))"
            marketView.plusButton.addTarget(self, action:Selector("plusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
            marketView.minusButton.addTarget(self, action:Selector("minusButtonTapped:") , forControlEvents: UIControlEvents.TouchDown)
            marketView.tag = i+1
            self.view.addSubview(marketView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //load xib file
    func loadTemplate(){
        let view:UIView = UINib(nibName: "HiringViewController", bundle: nil).instantiateWithOwner(self, options: nil)[0] as UIView
        self.view = view
    }
    
    //Check the action's availability
    func canDeduct() -> Bool {
        if(numberHiredDic[market] > 0){ return true}
        else {return false}
    }
    
    func canAdd() -> Bool {
        let sum = Array(numberHiredDic.values).reduce(0, +)
        if(cashBalance > sum*10) {return true}
        else {return false}
    }

    
    @IBAction func minusButtonTapped(sender: AnyObject) {
        var btn: UIButton = sender as UIButton
        var marketSubview:UIView = btn.superview as UIView!
        var marketView:MarketView = marketSubview.superview as MarketView
        market = marketNameArray[marketView.tag-1]
        if(self.canDeduct()){
            println("\(market) hired less")
            numberHiredDic[market] = numberHiredDic[market]! - 1
            marketView.numberLabel.text = "\(numberHiredDic[market]!)"
        }
    }
    @IBAction func plusButtonTapped(sender: AnyObject) {
        var btn: UIButton = sender as UIButton
        var marketSubview:UIView = btn.superview as UIView!
        var marketView:MarketView = marketSubview.superview as MarketView
        market = marketNameArray[marketView.tag-1]
        if (self.canAdd()) {
            println("\(market) hired more")
            numberHiredDic[market] = numberHiredDic[market]! + 1
            marketView.numberLabel.text = "\(numberHiredDic[market]!)"
        }
    }
    @IBAction func hireButtonPushed(sender: AnyObject) {
        for object : String in marketNameArray{
            cashBalance -= numberHiredDic[object]!*10
            numberOfEmployeesDic[object] = numberOfEmployeesDic[object]! + numberHiredDic[object]!
            println("\(object) = \(numberOfEmployeesDic[object]!)")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
