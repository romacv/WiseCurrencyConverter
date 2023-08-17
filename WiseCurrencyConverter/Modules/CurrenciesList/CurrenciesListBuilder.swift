// 
//  CurrenciesListBuilder.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import UIKit

final class CurrenciesListBuilder {
    
    static func build(
        dataStore: CurrencyModuleDataStore
    ) -> CurrenciesListVC {
        let view = CurrenciesListVC()
        let router = CurrenciesListRouter(view: view)
        let networkManager = OpenExchangeRatesManager()
        let presenter = CurrenciesListPresenter(
            view: view,
            router: router,
            networkManager: networkManager
        )
        presenter.dataStore = dataStore
        view.presenter = presenter
        return view
    }
}
