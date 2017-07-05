//
//  HomeScreenTableViewCell.swift
//  MyFitnessPalDemo
//
//  Created by zhen gong on 7/3/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class HomeScreenTableViewCell: UITableViewCell {

    // MARK: - Properties    
    
    var milesLabel:UILabel!
    var dateLabel:UILabel!
    var arrowButton:UIButton!

    // MARK: - Initializer
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        _setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported.")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    fileprivate func _setup() {
        milesLabel = UILabel()
        milesLabel.backgroundColor = UIColor.white
        milesLabel.textAlignment = .left
        milesLabel.font = UIFont.defaultMediumFont(of: 18)
        self.contentView.addSubview(milesLabel.usingConstraints())
        dateLabel = UILabel()
        dateLabel.backgroundColor = UIColor.white
        dateLabel.font = UIFont.defaultLightFont(of: 16)
        dateLabel.textAlignment = .right
        self.contentView.addSubview(dateLabel.usingConstraints())
        arrowButton = UIButton()
        arrowButton.setBackgroundImage(UIImage(named: "icon_arrow_right_black"), for: UIControlState.normal)
        self.contentView.addSubview(arrowButton.usingConstraints())
        _setupConstraints()
    }
    
    fileprivate func _setupConstraints() {
        let views : [String: UIView] = ["milesLabel":milesLabel, "dateLabel":dateLabel, "arrowButton":arrowButton]
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(15)-[milesLabel]-(20)-[dateLabel]-(5)-[arrowButton(10)]-|", options: [], metrics: nil, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|-[milesLabel]-|", options: [], metrics: nil, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|-[dateLabel]-|", options: [], metrics: nil, views: views))
        self.arrowButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
        self.arrowButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
