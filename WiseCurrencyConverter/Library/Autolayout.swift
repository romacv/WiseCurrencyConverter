//
//  Autolayout.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

import UIKit

@propertyWrapper
public struct UsingAutoLayout<T: UIView> {
    
    public var wrappedValue: T {
        didSet {
            setAutoLayout()
        }
    }
    
    public init (wrappedValue: T) {
        self.wrappedValue = wrappedValue
        setAutoLayout()
    }
    
    func setAutoLayout() {
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
