//
//  DetailScreenTableViewCell.swift
//  MyFitnessPalDemo
//
//  Created by zhen gong on 7/5/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import UIKit

class DetailScreenTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    var titleLabel:UILabel!
    var contentLabel:UILabel!

    // MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported.")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        _setup()
    }
    
    fileprivate func _setup() {
        titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 16)
        self.contentView.addSubview(titleLabel.usingConstraints())
        contentLabel = UILabel()
        contentLabel.backgroundColor = UIColor.white
        contentLabel.textAlignment = .right
        self.contentView.addSubview(contentLabel.usingConstraints())
        _setupConstraints()
    }
    
    fileprivate func _setupConstraints() {
        let views : [String: UIView] = ["titleLabel":titleLabel, "contentLabel":contentLabel]
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel]-[contentLabel]-|", options: [], metrics: nil, views: views))
        self.titleLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1 / 2)
        self.contentLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1 / 2)
        NSLayoutConstraint(item: self.titleLabel, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: self.contentLabel, attribute: .left, relatedBy: .equal, toItem: self.titleLabel, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title:String, content:String) {
        self.titleLabel.text = title
        self.contentLabel.text = content
    }

}
