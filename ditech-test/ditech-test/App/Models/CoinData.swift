//
//  CoinListModel.swift
//  ditech-test
//
//  Created by Andres Diaz  on 25/08/23.
//

import Foundation
import UIKit
struct CoinData: Decodable {
    let assetID: String?
    let name: String?
    let isCrypto: Int?
    let dataQuoteStart: String?
    let dataQuoteEnd: String?
    let dataOrderbookStart: String?
    let dataOrderbookEnd: String?
    let dataTradeStart: String?
    let dataTradeEnd: String?
    let dataSymbolsCount: Int?
    let volume1HrUSD: Double?
    let volume1DayUSD: Double?
    let volume1MonthUSD: Double?
    let idIcon: String?
    let dataStart: String?
    let dataEnd: String?
    let price: Double?
    var image: UIImage?
    
    private enum CodingKeys: String, CodingKey {
        case assetID = "asset_id"
        case name
        case price = "price_usd"
        case isCrypto = "type_is_crypto"
        case dataQuoteStart = "data_quote_start"
        case dataQuoteEnd = "data_quote_end"
        case dataOrderbookStart = "data_orderbook_start"
        case dataOrderbookEnd = "data_orderbook_end"
        case dataTradeStart = "data_trade_start"
        case dataTradeEnd = "data_trade_end"
        case dataSymbolsCount = "data_symbols_count"
        case volume1HrUSD = "volume_1hrs_usd"
        case volume1DayUSD = "volume_1day_usd"
        case volume1MonthUSD = "volume_1mth_usd"
        case idIcon = "id_icon"
        case dataStart
        case dataEnd
    }
}
