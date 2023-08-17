//
//  Themed.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

import Foundation

protocol Themed {
    var theme: ThemeProvider { get set }
    func applyTheme()
}
