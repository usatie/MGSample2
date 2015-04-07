//
//  HiringView.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/07.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit
class HiringView: UIView {
    //Parts from Nib
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var minusButton: UIButton!
    
    
    @IBInspectable var myCornerRadius : CGFloat {
        get {return self.layer.cornerRadius}
        set {self.layer.cornerRadius = newValue}
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        var view:UIView = NSBundle.mainBundle().loadNibNamed("HiringView", owner: self, options: nil).first as UIView
        self.addSubview(view)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        var view:UIView = NSBundle.mainBundle().loadNibNamed("HiringView", owner: self, options: nil).first as UIView
        self.addSubview(view)
    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        var view:HiringView = NSBundle.mainBundle().loadNibNamed("HiringView", owner: self, options: nil).first as HiringView
//    }
}

