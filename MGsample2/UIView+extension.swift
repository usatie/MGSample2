//
//  UIView+extension.swift
//  MGsample2
//
//  Created by Shun Usami on 2015/04/07.
//  Copyright (c) 2015年 ShunUsami. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}