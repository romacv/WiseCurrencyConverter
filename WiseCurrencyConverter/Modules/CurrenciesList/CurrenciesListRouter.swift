// 
//  CurrenciesListRouter.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import UIKit

protocol CurrenciesListRoutable {
    func dismissList()
}

final class CurrenciesListRouter: CurrenciesListRoutable {
    
    // MARK: - Properties
    
    private weak var view: CurrenciesListVC?
    
    // MARK: - Init
    
    init(view: CurrenciesListVC) {
        self.view = view
    }
    
    // MARK: - CurrenciesListRoutable Protocol Methods
    
    func dismissList() {
        view?.dismiss(animated: true)
    }
}
