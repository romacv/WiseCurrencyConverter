//
//  CurrencyConverterNetworkManager.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

import Foundation

protocol CurrencyConverterNetworkManager {
    
    func convertCurrency(
        from: String,
        to: String,
        amount: Double
    ) async throws -> Double
    func availableCurrencies() async throws -> [Currency]
}
