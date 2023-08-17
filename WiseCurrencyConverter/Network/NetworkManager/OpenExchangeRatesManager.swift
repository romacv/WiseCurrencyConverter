//
//  OpenExchangeRatesManager.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

import Foundation

class OpenExchangeRatesManager: CurrencyConverterNetworkManager {
    
    var appId: String = "8cf13d8c00ec4b9a9ad45994bd3c09eb"
    
    func convertCurrency(from: String, to: String, amount: Double) async throws -> Double {
        let url = URL(string: APIEndpoints.url(for: .latest))!.appending(
                queryItems: [
                    URLQueryItem(name: "app_id", value: appId)
                ]
            )
            let (data, _) = try await URLSession.shared.data(from: url)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            guard let rates = json?["rates"] as? [String: Double],
                  let fromRate = rates[from],
                  let toRate = rates[to] else {
                throw NSError(
                    domain: "",
                    code: 100,
                    userInfo: [NSLocalizedDescriptionKey: "Could not find rates for the currencies"]
                )
            }
            let conversionRate = toRate / fromRate
            let convertedAmount = amount * conversionRate
            return convertedAmount
        
    }

    func availableCurrencies() async throws -> [Currency] {
        let url = URL(string: APIEndpoints.url(for: .currencies))!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let currencyList = try decoder.decode(
            [String: String].self,
            from: data
        ).map {
            Currency(currencyCode: $0.key, currencyName: $0.value)
        }
        return currencyList
    }
}
