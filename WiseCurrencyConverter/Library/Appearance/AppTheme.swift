//
//  AppTheme.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

import UIKit

struct AppTheme: ThemeProvider {
    
    static let shared = AppTheme()
    private init() {}
    
    // Colors
    var mainBackgroundColor: UIColor {
        return .white
    }
    
    var enabledBackgroundColor: UIColor {
        return UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)
    }
    
    var disabledBackgroundColor: UIColor {
        return .gray
    }
    
    var enabledTextColor: UIColor {
        return .black
    }
    
    var disabledTextColor: UIColor {
        return .gray.withAlphaComponent(0.5)
    }
    
    // Fonts
    var titleFont: UIFont {
        let font = UIFont.systemFont(ofSize: 34, weight: .bold)
        let roundedFontDescriptor = font.fontDescriptor.withDesign(.rounded)!
        return UIFont(descriptor: roundedFontDescriptor, size: 34)
    }
    
    var hintFont: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .light)
    }
    
    var switcherFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 20)
    }
    
    var bodyFont: UIFont {
        return UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    var inputFont: UIFont {
        let font = UIFont.systemFont(ofSize: 32, weight: .bold)
        let roundedFontDescriptor = font.fontDescriptor.withDesign(.rounded)!
        return UIFont(descriptor: roundedFontDescriptor, size: 32)
    }
    
    var buttonFont: UIFont {
        return UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    var symbolFont: UIFont {
        return UIFont.systemFont(ofSize: 44, weight: .bold)
    }
    
}
