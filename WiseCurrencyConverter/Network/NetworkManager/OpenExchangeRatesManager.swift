//
//  OpenExchangeRatesManager.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

import Foundation

class OpenExchangeRatesManager: CurrencyConverterNetworkManager {
    var appId: String = "8cf13d8c00ec4b9a9ad45994bd3c09eb"
    let networkManager = NetworkManager()

    func convertCurrency(from: String, to: String, amount: Double) async throws -> Double {
        let endpoint = API.Factory.createLatestEndpoint()
        guard let url = URL(string: endpoint.url) else {
            throw NetworkError.invalidURL
        }
        let conversionData: ConversionRate
        do {
            let url = url.appending(queryItems: [URLQueryItem(name: "app_id", value: appId)])
            conversionData = try await networkManager.fetchData(from: url, shouldCancelCurrentTask: true)
        } catch {
            throw NetworkError.parsingError
        }
        
        guard let fromRate = conversionData.rates[from],
              let toRate = conversionData.rates[to] else {
            throw NetworkError.conversionError
        }
        
        let rate = toRate / fromRate
        let convertedAmount = amount * rate
        return convertedAmount
    }

    func availableCurrencies() async throws -> [Currency] {
        let endpoint = API.Factory.createCurrenciesEndpoint()
        guard let url = URL(string: endpoint.url) else {
            throw NetworkError.invalidURL
        }
        let currencyDict: [String: String]
        do {
            currencyDict = try await networkManager.fetchData(from: url)
        } catch {
            throw NetworkError.parsingError
        }
        
        return currencyDict.map { Currency(currencyCode: $0.key, currencyName: $0.value) }
    }
}
