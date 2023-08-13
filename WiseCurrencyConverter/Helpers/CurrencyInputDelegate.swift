//
//  CurrencyInputDelegate.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

import Foundation
import UIKit

class CurrencyInputDelegate: NSObject, UITextFieldDelegate {
    
    var valueChangedHandler: ((String) -> Void)?
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        let updatedText = updateText(text: text, range: range, replacementString: string)
        textField.text = updatedText
        valueChangedHandler?(updatedText)
        return false
    }
    
    private func updateText(text: String, range: NSRange, replacementString string: String) -> String {
        let updatedText = (text as NSString).replacingCharacters(in: range, with: string)
        let pattern = "^\\d{0,12}(\\.\\d{0,2})?$"
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .anchorsMatchLines) else {
            return text
        }
        
        let range = NSRange(location: 0, length: updatedText.utf16.count)
        let matches = regex.matches(in: updatedText, options: [], range: range)
        let isValid = matches.count > 0
        
        return isValid ? updatedText : text
    }
}
