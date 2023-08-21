//
//  CurrencySymbolImageGenerator.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 15-08-2023.
//

import UIKit

struct CurrencySymbolGenerator {
    
    func getCurrencySymbol(for currency: String) -> (symbol: String, isEmoji: Bool) {
        let flag = getFlag(for: currency)
        if let flag = flag {
            return (flag, true)
        } else {
            return (currency, false)
        }
    }

    private func getFlag(for currency: String) -> String? {
        guard let url = Bundle.main.url(forResource: "currency-data", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] else {
            return nil
        }
        
        return json[currency]
    }
}
