//
//  BeerCell.swift
//  BeerListApp
//
//  Created by AZM on 2021/01/22.
//

import UIKit
import SnapKit
import Kingfisher

class BeerCell: UITableViewCell {
    
    //MARK: - Properties
    
    let beerImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.layer.cornerRadius = 25
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let taglineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)

        return label
    }()
    
//    let indicatorView: UIActivityIndicatorView!
        
        //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subviewElements()
        configure(with: .none)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func subviewElements() {
        
        //beerImageView
        contentView.addSubview(beerImageView)
        beerImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(10)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.width.equalTo(50)
        }
        
        //nameLabel
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(beerImageView.snp.right).offset(10)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.right.equalToSuperview().inset(20)
        }
        
        //tagline
        contentView.addSubview(taglineLabel)
        taglineLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
            make.left.equalTo(beerImageView.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).inset(20)
        }
    }
    
    func configure(with beer: Beer?) {
      if let beer = beer {
        beerImageView.kf.setImage(with: URL(string: beer.imageURL))
        nameLabel.text = beer.name
        taglineLabel.text = beer.tagline
//        reputationLabel?.text = moderator.reputation
//        displayNameLabel.alpha = 1
//        reputationContainerView.alpha = 1
//        indicatorView.stopAnimating()
      }
//       else {
//        displayNameLabel.alpha = 0
//        reputationContainerView.alpha = 0
////        indicatorView.startAnimating()
      }
    
}

