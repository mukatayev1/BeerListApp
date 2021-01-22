//
//  Service.swift
//  BeerListApp
//
//  Created by AZM on 2021/01/21.
//

import UIKit
import Alamofire

class NetworkingService {
    
    let url = "https://api.punkapi.com/v2/beers"
    
    let beerArray = [Beer].self
    
    var page = 1
    
    //MARK: - Methods
    
    func getInitialBeers(completion: @escaping ([Beer]) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: beerArray) { response in
                
                if let beers = response.value {
                    completion(beers)
                    self.page = beers.count/25
                }
            }
    }
    
    func getBeers(page: Int, completion: @escaping ([Beer]) -> Void) {
        let parameters: Parameters = ["page": page,
                                      "per_page": 25
        ]
        
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: beerArray) { response in
                
                if let beers = response.value {
                    completion(beers)
                    self.page = beers.count/25
                }
            }
    }
    
    func checkServiceResult(completion: @escaping (Any?) -> Void) {
        AF.request(url)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(response.result)
                case .failure(let error):
                    print(error)
                }
            }
    }

    
}
