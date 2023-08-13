// 
//  CurrenciesListPresenter.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import Foundation

protocol CurrenciesListPresenterProtocol: AnyObject {
    init(view: CurrenciesListVCProtocol, router: CurrenciesListRouterProtocol)
    func didSelectItem(index: UInt)
}

final class CurrenciesListPresenter: CurrenciesListPresenterProtocol {
    
    private weak var view: CurrenciesListVCProtocol?
    private var router: CurrenciesListRouterProtocol
    var dataStore: DataStore?
    
    init(view: CurrenciesListVCProtocol, router: CurrenciesListRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func didSelectItem(index: UInt) {
        dataStore?.selectedElement = "abc"
        router.dismissList()
        dataStore?.updateData()
    }
}
