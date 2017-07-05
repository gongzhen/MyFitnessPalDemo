//
//  UIView+Constraints.swift
//  MyFitnessPalDemo
//
//  Created by zhen gong on 7/3/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

extension UIView {
    
    public func usingConstraints() -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }

}
