//
//  BeersViewModels.swift
//  BeerListApp
//
//  Created by AZM on 2021/01/22.
//

import UIKit
import Alamofire

protocol BeersViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class BeersViewModel {
    private weak var delegate: BeersViewModelDelegate?
    
    private var beers: [Beer] = []
    private var currentPage = 1
    private var total = 7314
    private var isFetchInProgress = false
    
    let service = NetworkingService()
    
    init(delegate: BeersViewModelDelegate) {
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return beers.count
    }
    
    func beer(at index: Int) -> Beer {
        return beers[index]
    }
    
    func fetchFirstBeers() {
        // 1
        guard !isFetchInProgress else {
            return
        }
        // 2
        isFetchInProgress = true
        service.getInitialBeers { (responseBeers) in
            DispatchQueue.main.async {
                self.isFetchInProgress = false
                self.beers.append(contentsOf: responseBeers)
                self.delegate?.onFetchCompleted(with: .none)
            }
        }
    }
    
    func fetchBeers() {
        //1
        guard !isFetchInProgress else {
            return
        }
        // 2
        isFetchInProgress = true
        //3
        service.getBeers(page: currentPage) { (responseBeers) in
            DispatchQueue.main.async {
                // 1
                self.currentPage += 1
                self.isFetchInProgress = false
                // 2
//                self.total = response.total
                self.beers.append(contentsOf: responseBeers)
                
                // 3
                if self.service.page > 1 {
                    let indexPathsToReload = self.calculateIndexPathsToReload(from: responseBeers)
                    self.delegate?.onFetchCompleted(with: indexPathsToReload)
                } else {
                    self.delegate?.onFetchCompleted(with: .none)
                }
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newBeers: [Beer]) -> [IndexPath] {
        let startIndex = beers.count - newBeers.count
        print(startIndex)
        let endIndex = startIndex + newBeers.count
        print(endIndex)
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
}
