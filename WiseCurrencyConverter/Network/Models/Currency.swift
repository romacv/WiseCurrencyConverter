//
//  Currency.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 15-08-2023.
//

import Foundation

struct Currency: Codable, Equatable {
    let currencyCode: String
    let currencyName: String
    
    static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.currencyCode == rhs.currencyCode
    }
}
