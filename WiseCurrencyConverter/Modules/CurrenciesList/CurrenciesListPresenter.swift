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
    func items() -> [Currency]
    func itemsCount() -> Int
    func didChangeSearchText(searchText: String)
    func close()
}

final class CurrenciesListPresenter: CurrenciesListPresentable {
    
    // MARK: - CurrenciesListPresentable Protocol Properties
    
    weak var dataStore: CurrencyModuleDataStore?
    
    // MARK: - Properties
    
    private weak var view: CurrenciesListView?
    private var router: CurrenciesListRoutable
    private var networkManager: CurrencyConverterNetworkManager!
    
    // MARK: - Initialization
    
    init(
        view: CurrenciesListView,
        router: CurrenciesListRoutable,
        networkManager: CurrencyConverterNetworkManager
    ) {
        self.view = view
        self.router = router
        self.networkManager = networkManager
    }
    
    // MARK: - CurrenciesListPresentable Protocol Methods
    
    func fetchCurrencies() {
        Task {
            do {
                let currencies = try await networkManager.availableCurrencies()
                dataStore?.elements = currencies.sorted(by: { $0.currencyCode < $1.currencyCode })
                dataStore?.filteredElements = dataStore?.elements ?? []
                DispatchQueue.main.async {
                    self.view?.refreshTable()
                }
            } catch {
                DispatchQueue.main.async {
                    self.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func didSelectItem(index: Int) {
        dataStore?.selectedElement = dataStore?.filteredElements[index]
        router.dismissList()
        dataStore?.updateData()
    }
    
    func items() -> [Currency] {
        dataStore?.filteredElements ?? []
    }
    
    func itemsCount() -> Int {
        dataStore?.filteredElements.count ?? 0
    }
    
    func didChangeSearchText(searchText: String) {
        if searchText.isEmpty {
            dataStore?.filteredElements = dataStore?.elements ?? []
        }
        else {
            let lowercasedSearchText = searchText.lowercased()
            dataStore?.filteredElements = dataStore?.elements.filter {
                let lowercasedCurrencyCode = $0.currencyCode.lowercased()
                let lowercasedCurrencyName = $0.currencyName.lowercased()
                return lowercasedCurrencyCode.contains(lowercasedSearchText) ||
                lowercasedCurrencyName.contains(lowercasedSearchText)
            } ?? []
        }
        view?.refreshTable()
    }
    
    func close() {
        router.dismissList()
    }
}

