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
        .white
    }
    
    var enabledBackgroundColor: UIColor {
        UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)
    }
    
    var disabledBackgroundColor: UIColor {
        .gray
    }
    
    var enabledTextColor: UIColor {
        .black
    }
    
    var disabledTextColor: UIColor {
        .gray.withAlphaComponent(0.5)
    }
    
    // Fonts
    var titleFont: UIFont {
        let font = UIFont.systemFont(ofSize: 34, weight: .bold)
        let roundedFontDescriptor = font.fontDescriptor.withDesign(.rounded)!
        return UIFont(descriptor: roundedFontDescriptor, size: 34)
    }
    
    var hintFont: UIFont {
        UIFont.systemFont(ofSize: 14, weight: .light)
    }
    
    var switcherFont: UIFont {
        UIFont.boldSystemFont(ofSize: 20)
    }
    
    var bodyFont: UIFont {
        UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    var inputFont: UIFont {
        let font = UIFont.systemFont(ofSize: 32, weight: .bold)
        let roundedFontDescriptor = font.fontDescriptor.withDesign(.rounded)!
        return UIFont(descriptor: roundedFontDescriptor, size: 32)
    }
    
    var buttonFont: UIFont {
        UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    var symbolFont: UIFont {
        UIFont.systemFont(ofSize: 44, weight: .bold)
    }
    
}
