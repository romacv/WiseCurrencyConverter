// 
//  CurrenciesListPresenter.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import Foundation

protocol CurrenciesListPresentable: AnyObject {
    func fetchCurrencies()
    func didSelectItem(index: Int)
    func items() -> [String : String]
    func itemsCount() -> Int
}

final class CurrenciesListPresenter: CurrenciesListPresentable {
    
    private weak var view: CurrenciesListVCProtocol?
    private var router: CurrenciesListRouterProtocol
    private var networkManager: CurrencyConverterNetworkManager!
    var dataStore: DataStore?
    
    init(
        view: CurrenciesListVCProtocol,
        router: CurrenciesListRouterProtocol,
        networkManager: CurrencyConverterNetworkManager
    ) {
        self.view = view
        self.router = router
        self.networkManager = networkManager
    }
    
    func fetchCurrencies() {
        Task {
            do {
                let currencies = try await networkManager.availableCurrencies()
                dataStore?.elements = currencies
                self.view?.refreshTable()
            } catch {
                self.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func didSelectItem(index: Int) {
        dataStore?.selectedElement = "abc"
        router.dismissList()
        dataStore?.updateData()
    }
    
    func items() -> [String : String] {
        return dataStore?.elements ?? [:]
    }
    
    func itemsCount() -> Int {
        return dataStore?.elements.keys.count ?? 0
    }
}

