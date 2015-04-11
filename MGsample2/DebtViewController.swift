//
//  DebtViewController.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/10.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

class DebtViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet var debtLabel: UILabel!
    @IBOutlet var maxDebtLabel: UILabel!
    
    @IBOutlet var debtPickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadTemplate()
        maxDebtLabel.text = "現在の借入可能額：\(maxDebt)円"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTemplate(){
        let DebtView:UIView = UINib(nibName: "DebtViewController", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! UIView
        view = DebtView
    }
    
    @IBAction func debtButtonPushed(sender: AnyObject) {
        var debt = maxDebt - debtPickerView.selectedRowInComponent(0)
        maxDebt -= debt
        cashBalance += (debt - debt*interestRate/100)
        currentDebt += debt
        dismissViewControllerAnimated(true, completion: nil)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxDebt+1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(maxDebt - row)"
    }
}
