// 
//  HomeBuilder.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import UIKit

final class HomeBuilder {
    
    static func build(theme: ThemeProvider) -> HomeVC {
        let view = HomeVC()
        let router = HomeRouter(view: view)
        let networkManager = OpenExchangeRatesManager()
        let presenter = HomePresenter(
            view: view,
            router: router,
            networkManager: networkManager
        )
        view.presenter = presenter
        view.theme = theme
        
        return view
    }
    
}
