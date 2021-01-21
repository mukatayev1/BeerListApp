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
    
    //MARK: - Methods
    
    func getBeers(completion: @escaping ([Beer]) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: beerArray) { response in
                
                if let responseValue = response.value {
                    completion(responseValue)
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
