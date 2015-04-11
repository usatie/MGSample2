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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return maxDebt
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(row)"
    }
}
