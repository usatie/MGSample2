//
//  MarketView.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/07.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

class MarketView: UIView {
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var propertyLabel: UILabel!

    @IBOutlet var plusButton: UIButton!
    @IBOutlet var minusButton: UIButton!
    var number:Int = 0
    
    var type: String = ""
    
    @IBInspectable var myCornerRadius : CGFloat {
        get {return self.layer.cornerRadius}
        set {self.layer.cornerRadius = newValue}
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        var view:UIView = NSBundle.mainBundle().loadNibNamed("MarketView", owner: self, options: nil).first as UIView
        self.addSubview(view)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        var view:UIView = NSBundle.mainBundle().loadNibNamed("MarketView", owner: self, options: nil).first as UIView
        self.addSubview(view)
    }
}
