//
//  ConversionRate.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 21-08-2023.
//

import Foundation

struct ConversionRate: Codable {
    let rates: [String: Double]
}
