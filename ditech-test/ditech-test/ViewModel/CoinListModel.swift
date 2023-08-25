//
//  CoinListModel.swift
//  ditech-test
//
//  Created by Andres Diaz  on 25/08/23.
//

import Foundation

struct Token: Codable {
    let id: String
    let symbol: String
    let name: String
    let platforms: [String: String]
}
