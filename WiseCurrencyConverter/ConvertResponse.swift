//
//  ConvertResponse.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

struct ConvertResponse: Codable {
    let disclaimer: String
        let license: String
        let request: Request
        let meta: Meta
        let response: Double
        
        struct Request: Codable {
            let query: String
            let amount: Double
            let from: String
            let to: String
        }
        
        struct Meta: Codable {
            let timestamp: Int
            let rate: Double
        }
}
