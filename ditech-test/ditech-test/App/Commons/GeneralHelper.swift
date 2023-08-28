//
//  GeneralHelper.swift
//  ditech-test
//
//  Created by Andres Diaz  on 28/08/23.
//

import Foundation

class GeneralHelper {
   static func formatCurrencyValue(_ value: Double?) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        
        if let value = value {
            let priceNumber = NSNumber(value: value)
            if let formattedValue = formatter.string(from: priceNumber) {
                return formattedValue
            }
        }
        
        return "N/A"
    }
}
