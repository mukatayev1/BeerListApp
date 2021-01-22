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

class BeersListViewController: UIViewController  {
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
    
    private var viewModel: BeersViewModel!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Beers"
        view.backgroundColor = Colors.white
        configureTableView()
        configureIndicatorView()
        
        viewModel = BeersViewModel(delegate: self)
        viewModel.fetchFirstBeers()
        
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
        tableView.prefetchDataSource = self
    }
    
    func configureIndicatorView() {
        activityIndicator.style = .medium
        activityIndicator.color = .white
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSourc
extension BeersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.beerCell, for: indexPath) as! BeerCell

        if isLoadingCell(for: indexPath) {
          cell.configure(with: .none)
        } else {
          cell.configure(with: viewModel.beer(at: indexPath.row))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = viewModel.beer(at: indexPath.row)
        navigationController?.pushViewController(BeerDetailsViewController(beer: selectedItem), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        return indexPath
    }
}

//MARK: - BeersViewModelDelegate
extension BeersListViewController: BeersViewModelDelegate  {
    
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        // 1
          guard let newIndexPathsToReload = newIndexPathsToReload else {
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            return
          }
          // 2
          let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
          tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func onFetchFailed(with reason: String) {
        activityIndicator.stopAnimating()
        print(reason)
    }
}

//MARK: - UITableViewDataSourcePrefetching
extension BeersListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
          viewModel.fetchBeers()
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
      return indexPath.row >= viewModel.currentCount
    }

    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
      let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
      let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
      return Array(indexPathsIntersection)
    }
  }
