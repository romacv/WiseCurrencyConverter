//
//  Double+Extension.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 17-08-2023.
//

import Foundation

extension Double {
    
    func moneyToString() -> String {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return "\(Int(self))"
        } else {
            return String(format: "%.2f", self)
        }
    }
}
