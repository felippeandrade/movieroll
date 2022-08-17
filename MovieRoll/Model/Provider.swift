//
//  Provider.swift
//  MovieRoll
//
//  Created by Bruno Bezerra on 16/06/22.
//

import Foundation

class Provider: Decodable {
    var results: ProvidersResults
}

class BR: Decodable {
    var flatrate: [Flatrate]
}

class ProvidersResults: Decodable {
    var br: BR
    
    enum CodingKeys: String, CodingKey {
        case br = "BR"
    }
}

class Flatrate: Decodable {
    var providerId: Int
    
    enum CodingKeys: String, CodingKey {
        case providerId = "provider_id"
    }
}

