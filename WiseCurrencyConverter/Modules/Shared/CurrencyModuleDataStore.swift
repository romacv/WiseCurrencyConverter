//
//  CurrencyModuleDataStore.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 15-08-2023.
//

import Foundation

class CurrencyModuleDataStore: DataStore {
    
    typealias E = Currency
    
    // MARK: - Properties
    
    var selectedElement: Currency?
    var elements: [Currency] = []
    var filteredElements: [Currency] = []
    var dataUpdated: (() -> Void)?
    
    // MARK: - Methods
    
    func updateData() {
        dataUpdated?()
    }
}
