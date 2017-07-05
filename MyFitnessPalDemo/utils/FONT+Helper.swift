//
//  FONT+Helper.swift
//  MyFitnessPalDemo
//
//  Created by zhen gong on 7/5/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func defaultLightFont(of pointSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "HelveticaNeue-Light", size: pointSize) {
            return font
        }
        return UIFont.systemFont(ofSize: pointSize)
    }
    
    class func defaultMediumFont(of pointSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "HelveticaNeue-Medium", size: pointSize) {
            return font
        }
        return UIFont.systemFont(ofSize: pointSize)
    }


}

