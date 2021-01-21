//
//  ImageAndNameCell.swift
//  BeerListApp
//
//  Created by AZM on 2021/01/22.
//

import UIKit
import SnapKit

class ImageAndNameCell: UITableViewCell {

    
    //MARK: - Properties
    
    let beerImageView: UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 100
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let taglineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let firstBrewedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    //MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Colors.white
        selectionStyle = .none
        subviewElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func subviewElements() {
        
        //beerImageView
        contentView.addSubview(beerImageView)
        beerImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
        //nameLabel
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(beerImageView.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        //taglineLabel
        contentView.addSubview(taglineLabel)
        taglineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(20)
        }
        
        //firstBrewed
        contentView.addSubview(firstBrewedLabel)
        firstBrewedLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(30)
            
        }
    }
}
