// 
//  CurrenciesListRouter.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import UIKit

protocol CurrenciesListRouterProtocol {
    init(view: CurrenciesListVC)
    func dismissList()
}

final class CurrenciesListRouter: CurrenciesListRouterProtocol {
    
    private weak var view: CurrenciesListVC?
    
    init(view: CurrenciesListVC) {
        self.view = view
    }
    
    func dismissList() {
        view?.dismiss(animated: true)
    }
}
