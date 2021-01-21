//
//  BeersListViewController.swift
//  BeerListApp
//
//  Created by AZM on 2021/01/21.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

class BeersListViewController: UIViewController {
    
    //MARK: - Properties
    
    let service = NetworkingService()
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.register(BeerCell.self, forCellReuseIdentifier: CellReuseIdentifiers.beerCell)
        tv.backgroundColor = Colors.white
        return tv
    }()
    
    var beersArray = [Beer]()
    
    let activityIndicator = UIActivityIndicatorView()
    
    var selectedItem: Beer!
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Beers"
        view.backgroundColor = Colors.white
        configureTableView()
        fetchBeers()
        configureIndicatorView()
        //a loading animation in case data is loading slowly
        activityIndicator.startAnimating()
        service.checkServiceResult { (response) in
            self.activityIndicator.stopAnimating()
        }
    }
    
    //MARK: - Helpers
    
    func configureTableView() {
        //subview the tableView
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureIndicatorView() {
        activityIndicator.style = .medium
        activityIndicator.color = .white
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    func fetchBeers() {
        service.getBeers { (beers) in
            self.beersArray = beers
            self.tableView.reloadData()
        }
    }
}
//MARK: - Extensions
extension BeersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.beerCell, for: indexPath) as! BeerCell
        let beerItem = beersArray[indexPath.row]
        cell.nameLabel.text = beerItem.name
        cell.beerImageView.kf.setImage(with: URL(string: beerItem.imageURL))
        cell.taglineLabel.text = beerItem.tagline
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = beersArray[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(BeerDetailsViewController(beer: selectedItem), animated: true)
        return indexPath
    }
    
}
