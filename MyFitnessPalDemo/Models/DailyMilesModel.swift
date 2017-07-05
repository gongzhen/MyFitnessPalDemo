//
//  DailyMilesModel.swift
//  MyFitnessPalDemo
//
//  Created by zhen gong on 7/3/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class DailyMilesModel {
    
    var date:Date!
    var distance:String!
    var steps:String!
    var floorsAscended:String!
    var floorsDescended:String!
    var averageActivePace:String!
    
    init(date: Date, distance: Double?, steps:Int, floorsAscended:Int?, floorsDescended: Int?, averageActivePace: Int?) {
        self.date = date
        if let distance = distance {
            self.distance = String(format:"%.2f", distance)
        } else {
            self.distance = ""
        }
        self.steps = "\(steps)"
        if let floorsAscended = floorsAscended {
            self.floorsAscended = "\(floorsAscended)"
        } else {
            self.floorsAscended = "0"
        }
        
        if let floorsDescended = floorsDescended {
            self.floorsDescended = "\(floorsDescended)"
        } else {
            self.floorsDescended = "0"
        }
        if let averageActivePace = averageActivePace {
            self.averageActivePace = "\(averageActivePace)"
        } else {
            self.averageActivePace = "0"
        }    
    }
    
    

}
