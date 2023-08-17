// 
//  HomeRouter.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import UIKit

protocol HomeRoutable {
    func navigateCurrenciesList(dataStore: CurrencyModuleDataStore)
}

final class HomeRouter: HomeRoutable {
    
    // MARK: - Properties
    
    private weak var view: HomeVC?
    
    // MARK: - Init
    
    init(view: HomeVC) {
        self.view = view
    }
    
    // MARK: - HomeRoutable methods
    
    func navigateCurrenciesList(dataStore: CurrencyModuleDataStore) {
        let currenciesListVC = CurrenciesListBuilder.build(dataStore: dataStore)
        view?.present(currenciesListVC, animated: true)
    }
    
}
