// 
//  HomeRouter.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import UIKit

protocol HomeRoutable {
    init(view: HomeVC)
    func navigateCurrenciesList(dataStore: any DataStore)
}

final class HomeRouter: HomeRoutable {
    
    // MARK: - Properties
    
    private weak var view: HomeVC?
    
    // MARK: - Init
    
    init(view: HomeVC) {
        self.view = view
    }
    
    // MARK: - HomeRouterProtocol methods
    
    func navigateCurrenciesList(dataStore: any DataStore) {
        let currenciesListVC = CurrenciesListBuilder.build(theme: AppTheme.shared, dataStore: dataStore)
        view?.present(currenciesListVC, animated: true)
    }
    
}
