//
//  CurrencyConverterNetworkManager.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

import Foundation

protocol CurrencyConverterNetworkManager {
    
    var baseURL: String { get set }
    var appId: String { get set }
    func convertCurrency(
        from: String,
        to: String,
        amount: Double,
        completion: @escaping (Result<Double, Error>) -> Void
    )
}
