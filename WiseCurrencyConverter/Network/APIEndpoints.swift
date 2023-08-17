//
//  APIEndpoints.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 15-08-2023.
//

import Foundation

enum APIEndpoints {
    
    static let baseURL = "https://openexchangerates.org/api/"

    enum Paths: String {
        case latest = "latest.json"
        case currencies = "currencies.json"
    }

    static func url(for path: Paths) -> String {
        return baseURL + path.rawValue
    }
}
