//
//  OpenExchangeRatesManager.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

import Foundation

class OpenExchangeRatesManager: CurrencyConverterNetworkManager {
    var baseURL: String = "https://openexchangerates.org/api"
    var appId: String = "8cf13d8c00ec4b9a9ad45994bd3c09eb"
    
    
    func convertCurrency(from: String, to: String, amount: Double, completion: @escaping (Result<Double, Error>) -> Void) {
        completion(.success(amount*3.33))
    }

}
