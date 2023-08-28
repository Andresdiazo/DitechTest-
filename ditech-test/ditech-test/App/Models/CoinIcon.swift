//
//  CoinIcon.swift
//  ditech-test
//
//  Created by Andres Diaz  on 27/08/23.
//

import Foundation

struct CoinIcon: Decodable {
    let id: String?
    let url: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "asset_id"
        case url
    }
}
