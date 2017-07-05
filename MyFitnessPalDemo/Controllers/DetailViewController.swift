//
//  DetailViewController.swift
//  MyFitnessPalDemo
//
//  Created by zhen gong on 7/5/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

private let kReuseIdentifier = "detailScreenCellIdentifier"
class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties

    var tableView:UITableView!

    var dailyMileModel:DailyMilesModel!

    // MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        _setupView()
    }
    
    fileprivate func _setupView() {
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailScreenTableViewCell.self, forCellReuseIdentifier: kReuseIdentifier)
        view.addSubview(tableView.usingConstraints())
        _setupConstraints()
    }
    
    fileprivate func _setupConstraints() {
        // tableView constraints
        let tbTopConstraint = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy:.equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        let tbLeftConstraint = NSLayoutConstraint(item: tableView, attribute: .left, relatedBy:.equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0)
        let tbRightConstraint = NSLayoutConstraint(item: tableView, attribute: .right, relatedBy:.equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0)
        let tbBottomConstraint = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0)
        view.addConstraints([tbTopConstraint, tbLeftConstraint, tbRightConstraint, tbBottomConstraint])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DetailViewController {

    //MARK: TableView dataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let mileLabel = UILabel()
        mileLabel.text = "Details"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: kReuseIdentifier, for: indexPath) as! DetailScreenTableViewCell
        switch indexPath.row {
            case 0:
                cell.configureCell(title: "Steps", content: self.dailyMileModel.steps)
            break
            case 1:
                cell.configureCell(title: "Meters", content: self.dailyMileModel.distance)
                break
            case 2:
                cell.configureCell(title: "Floors as acended", content: self.dailyMileModel.floorsAscended)
                break
            case 3:
                cell.configureCell(title: "Floors as decended", content: self.dailyMileModel.floorsDescended)
                break
            case 4:
                cell.configureCell(title: "Average active pace", content: self.dailyMileModel.averageActivePace)
            default:
                break
        }
        return cell
    }
    
    fileprivate func configureCell(title:String, content:String, cell:DetailScreenTableViewCell) {
        cell.titleLabel.text = title
        cell.contentLabel.text = content
    }
    
}
