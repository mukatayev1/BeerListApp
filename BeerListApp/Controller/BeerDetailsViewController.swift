//
//  BeerDetailsViewController.swift
//  BeerListApp
//
//  Created by AZM on 2021/01/22.
//

import UIKit
import Kingfisher

class BeerDetailsViewController: UITableViewController {
    
    //MARK: - Properties
    
    private let beer: Beer!
    
    //MARK: - Lifecycle
    
    init(beer: Beer) {
        self.beer = beer
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Beer Description"
        tableView.separatorStyle = .none
        view.backgroundColor = Colors.white
        
        configureTableView()
    }
    
    //MARK: - Helpers
    func configureTableView() {
        tableView.register(ImageAndNameCell.self, forCellReuseIdentifier: CellReuseIdentifiers.imageAndNameCell)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: CellReuseIdentifiers.descriptionCell)
    }
}

//MARK: - Extensions

extension BeerDetailsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.imageAndNameCell, for: indexPath) as! ImageAndNameCell
            cell.nameLabel.text = beer.name
            cell.taglineLabel.text = beer.tagline
            cell.beerImageView.kf.setImage(with: URL(string: beer.imageURL))
            cell.firstBrewedLabel.text = "Brewed: \(beer.firstBrewed)"
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.descriptionCell, for: indexPath) as! DescriptionCell
            cell.descriptionTextLabel.text = beer.description
            
            for i in 0...beer.foodPairing.count {
                var index = 0
                cell.foodPairs.text = beer.foodPairing[index]
                index += 1
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.imageAndNameCell, for: indexPath) as! ImageAndNameCell
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0  {
            return 350
        } else if indexPath.row == 1 {
            return 220
        } else if indexPath.row == 2 {
            return 300
        } else {
            return 50
        }
    }
}
