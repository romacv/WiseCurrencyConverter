//
//  DataStore.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

protocol DataStore: AnyObject {
    
    // MARK: - Properties
    
    associatedtype E
    var selectedElement: E? { get set }
    var elements: [E] { get set }
    var onDataUpdated: (() -> Void)? { get set }

    // MARK: - Methods
    
    func updateData()
}

