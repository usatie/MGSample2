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
    var numberOfSearchEmployeeToHire = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("hiring")
        self.loadTemplate()
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
    
    //Check if the action's availability
    func canDeduct() -> Bool {
        if(numberOfSearchEmployeeToHire > 0){ return true}
        else {return false}
    }
    
    func canAdd() -> Bool {
        if(cashBalance > numberOfSearchEmployeeToHire*10) {return true}
        else {return false}
    }

    
    @IBAction func minusButtonTapped(sender: AnyObject) {
        if(self.canDeduct()){
            numberOfSearchEmployeeToHire--
            searchLabel?.text = "\(numberOfSearchEmployeeToHire)"
        }
    }
    @IBAction func plusButtonTapped(sender: AnyObject) {
        if (self.canAdd()) {
            numberOfSearchEmployeeToHire++
            searchLabel?.text = "\(numberOfSearchEmployeeToHire)"
        }
    }
    @IBAction func hireButtonPushed(sender: AnyObject) {
        cashBalance -= numberOfSearchEmployeeToHire*10
        numberOfSearchEmployee += numberOfSearchEmployeeToHire
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
