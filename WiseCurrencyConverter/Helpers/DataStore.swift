//
//  DataStore.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 13-08-2023.
//

protocol DataStore: AnyObject {
    var selectedElement: String? { get set }
    func updateData()
}
