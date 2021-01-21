//
//  BeerModel.swift
//  BeerListApp
//
//  Created by AZM on 2021/01/21.
//

import Foundation

struct Beer: Decodable, Hashable {
    let name: String
    let tagline: String
    let description: String
    let imageURL: String
    let foodPairing: [String]
    let firstBrewed: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case tagline
        case description
        case imageURL = "image_url"
        case foodPairing = "food_pairing"
        case firstBrewed = "first_brewed"
    }
}
