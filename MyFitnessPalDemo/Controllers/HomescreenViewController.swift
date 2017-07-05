//
//  HomescreenViewController.swift
//  MyFitnessPalDemo
//
//  Created by zhen gong on 7/3/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit
import CoreMotion

private let kReuseIdentifier = "homeScreenCellIdentifier"
private let maximumDays = 10

class HomescreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    var meterSwitchToSteps = false
    var dailyRecords:[DailyMilesModel] = []
    var pedometer = CMPedometer()
    var tableView:UITableView!
    lazy var today:Date = {
        let date = Date()
        return date
    }()
    
    lazy var dateFormatter:DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter
    }()
    
    // MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        self.title = "MyFitnessPal Coding Exercise"
        _setupView()
        
        if(CMPedometer.isStepCountingAvailable() == true) {
            print("isStepCountingAvailable OK")
            for i in 0..<maximumDays {
                let value = 0 - i
                let toDate = Calendar.current.date(byAdding: .day, value: value, to: today)!
                let fromDate = Calendar.current.date(byAdding: .day, value: -1, to: toDate)!
                self.getPedometerData(fromDate, to: toDate, completion: {[weak self] (pedometerData, error) -> Void in
                    guard error == nil else {
                        self?.dailyRecords = []
                        return
                    }
                    if let data = pedometerData {
                        let model = DailyMilesModel(date: toDate, distance: data.distance?.doubleValue, steps: data.numberOfSteps.intValue, floorsAscended: data.floorsDescended?.intValue, floorsDescended: data.floorsDescended?.intValue, averageActivePace: data.averageActivePace?.intValue)
                        self?.dailyRecords.append(model)
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    } else {
                        self?.dailyRecords = []
                    }
                })
            }
        } else {
            print("isStepCountingAvailable NO")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    fileprivate func getPedometerData(_ fromDate :Date, to toDate: Date, completion:@escaping (CMPedometerData?, Error?) -> Void) {
        pedometer.queryPedometerData(from: fromDate, to: toDate) { (pedometerData, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            if let pedometerData = pedometerData {
                completion(pedometerData, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    fileprivate func _setupView() {
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: kReuseIdentifier)
        view.addSubview(tableView.usingConstraints())
        _setupConstraints()
    }
    
    fileprivate func _setupConstraints() {
        // tableView constraints
        let tbTopConstraint = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy:.equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
        let tbLeftConstraint = NSLayoutConstraint(item: tableView, attribute: .left, relatedBy:.equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0)
        let tbRightConstraint = NSLayoutConstraint(item: tableView, attribute: .right, relatedBy:.equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0)
        let tbBottomConstraint = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        view.addConstraints([tbTopConstraint, tbLeftConstraint, tbRightConstraint, tbBottomConstraint])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func switchMetherButtonTap(sender: UIButton) {
        if meterSwitchToSteps == false {
            meterSwitchToSteps = true
            
        } else {
            meterSwitchToSteps = false
        }
    }
}

extension HomescreenViewController {
    
    //MARK: TableView dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dailyRecords.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let mileLabel = UILabel()
        mileLabel.text = "STEPS"
        mileLabel.textAlignment = NSTextAlignment.left
        headerView.addSubview(mileLabel.usingConstraints())
        headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[mileLabel(100)]", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["mileLabel" : mileLabel]))
        headerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[mileLabel(40)]", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["mileLabel" : mileLabel]))
        headerView.backgroundColor = UIColor.cyan
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kReuseIdentifier, for: indexPath) as! HomeScreenTableViewCell
        let model = self.dailyRecords[indexPath.row]
        cell.milesLabel.text = model.steps
        cell.dateLabel.text = dateFormatter.string(from: model.date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.dailyRecords[indexPath.row]
        let detailViewController = DetailViewController()
        detailViewController.dailyMileModel = model
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

}

