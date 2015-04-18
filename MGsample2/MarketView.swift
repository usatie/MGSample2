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
    @IBOutlet var fullButton: UIButton!
    var number:Int = 0
    
    var type: String = ""
    
    @IBInspectable var myCornerRadius : CGFloat {
        get {return layer.cornerRadius}
        set {layer.cornerRadius = newValue}
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        var marketView:UIView = NSBundle.mainBundle().loadNibNamed("MarketView", owner: self, options: nil).first as! UIView
        addSubview(marketView)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        var marketView:UIView = NSBundle.mainBundle().loadNibNamed("MarketView", owner: self, options: nil).first as! UIView
        addSubview(marketView)
    }
}
