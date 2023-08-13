// 
//  CurrenciesListBuilder.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import UIKit

final class CurrenciesListBuilder {
    
    static func build(
        theme: ThemeProvider,
        dataStore: any DataStore
    ) -> CurrenciesListVC {
        typealias T = String
        let view = CurrenciesListVC()
        let router = CurrenciesListRouter(view: view)
        let presenter = CurrenciesListPresenter(view: view, router: router)
        presenter.dataStore = dataStore
        view.presenter = presenter
        
        return view
    }
    
}
