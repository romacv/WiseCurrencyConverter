// 
//  HomeBuilder.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import UIKit

final class HomeBuilder {
    
    static func build() -> HomeVC {
        let view = HomeVC()
        let router = HomeRouter(view: view)
        let networkManager = OpenExchangeRatesManager()
        let dataStore = CurrencyModuleDataStore()
        let presenter = HomePresenter(
            view: view,
            router: router,
            networkManager: networkManager
        )
        presenter.dataStore = dataStore
        view.presenter = presenter
        return view
    }
}
