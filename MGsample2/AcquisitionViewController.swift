//
//  AcquisitionViewController.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/09.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

class AcquisitionViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet var marketSegmentedControl: UISegmentedControl!
    @IBOutlet var ownerSegmentedControl: UISegmentedControl!

    @IBOutlet var acquisitionPickerView: UIPickerView!
    @IBOutlet var competingPricePickerView: UIPickerView!

    @IBOutlet var acquisitionLabel: UILabel!
    @IBOutlet var acquiringAbilityLabel: UILabel!
    @IBOutlet var listingPriceLabel: UILabel!
    
    var acquiringAbility = 0
    var listingPrice = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadTemplate()
        competingPricePickerView.selectRow(100, inComponent: 0, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTemplate(){
        let AcquisitionView:UIView = UINib(nibName: "AcquisitionViewController", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        view = AcquisitionView
    }
    
    func updateListingPrice() {
        if marketSegmentedControl.selectedSegmentIndex != UISegmentedControlNoSegment {
            listingPrice = competingPricePickerView.selectedRowInComponent(0)
            if ownerSegmentedControl.selectedSegmentIndex == 1{listingPrice += 2}
            let market = marketSegmentedControl.titleForSegmentAtIndex(marketSegmentedControl.selectedSegmentIndex)!
            listingPrice += numberOfSharesDic[market]!
            listingPriceLabel.text = "掲載価格\(listingPrice)"
            acquiringAbility = min(employeesDic["Sales"]!["Search"]!, (numberOfSharesDic[market]!+1)/2)
            acquiringAbilityLabel.text = "広告獲得能力：\(acquiringAbility)"
            acquisitionLabel.text = "\(acquisitionPickerView.selectedRowInComponent(0)*listingPrice)万円"
        }
        
    }
    
    //PickerView Delegate methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView{
        case competingPricePickerView:
            return 201
        case acquisitionPickerView:
            println("numberOfRowsInComponent and acquisitionPickerView")
            println("ability \(acquiringAbility)")
            return acquiringAbility+1
        default :
            return 10
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(row)"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateListingPrice()
        println("row\(row), component\(component)")
    }
    
    //Button Action
    @IBAction func didOwnerSelected(sender: AnyObject) {
        updateListingPrice()
        println("ability \(acquiringAbility)")
        acquisitionPickerView.reloadAllComponents()
    }
    @IBAction func didMarketSelected(sender: AnyObject) {
        updateListingPrice()
        acquisitionPickerView.reloadAllComponents()
        acquisitionLabel.text = "\(acquisitionPickerView.selectedRowInComponent(0)*listingPrice)万円"
    }
    @IBAction func acquireButtonPushed(sender: AnyObject) {
        cashBalance += acquisitionPickerView.selectedRowInComponent(0)*listingPrice
        dismissViewControllerAnimated(true, completion: nil)
    }
}
