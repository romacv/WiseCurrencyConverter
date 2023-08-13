//
//  ThemeProvider.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

import UIKit

protocol ThemeProvider {
    
    // Colors
    var enabledBackgroundColor: UIColor { get }
    var disabledBackgroundColor: UIColor { get }
    var enabledTextColor: UIColor { get }
    var disabledTextColor: UIColor { get }

    // Fonts
    var titleFont: UIFont { get }
    var hintFont: UIFont { get }
    var inputFont: UIFont { get }
    var switcherFont: UIFont { get }
    var bodyFont: UIFont { get }
    var buttonFont: UIFont { get }
}
