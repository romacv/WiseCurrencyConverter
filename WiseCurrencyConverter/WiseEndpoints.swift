//
//  WiseEndpoints.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

import Foundation

enum WiseEndpoints {
    case convert(from: String, to: String, amount: Double)
    
    var path: String {
        switch self {
        case .convert(let from, let to, let amount):
            return "/v1/rates?source=\(from)&target=\(to)&amount=\(amount)"
        }
    }
}
