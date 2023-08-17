//
//  NetworkError.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case networkError
    case parsingError
    case conversionError
}
