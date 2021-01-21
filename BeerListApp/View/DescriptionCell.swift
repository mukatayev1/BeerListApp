//
//  DescriptionCellCell.swift
//  BeerListApp
//
//  Created by AZM on 2021/01/22.
//

import UIKit
import SnapKit

class DescriptionCell: UITableViewCell {
    
    //MARK: - Properties
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "Description"
        return label
    }()
    
    let descriptionTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    let foodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "Food Pairs"
        return label
    }()
    
    let foodPairs: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Colors.white
        subviewElements()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func subviewElements() {
        //Description label
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(25)
            make.height.equalTo(20)
        }
        
        //Description Text label
        contentView.addSubview(descriptionTextLabel)
        descriptionTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(25)
            make.right.equalToSuperview().inset(8)
        }
        
        //Foodlabel
        contentView.addSubview(foodLabel)
        foodLabel.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionTextLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(25)
            make.height.equalTo(20)
        }
        
        //Pairs
        contentView.addSubview(foodPairs)
        foodPairs.snp.makeConstraints { (make) in
            make.top.equalTo(foodLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(25)
            make.right.equalToSuperview().inset(8)
        }
        
    }
}
