// 
//  HomePresenter.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import Foundation

protocol HomePresentable<CurrencyAmount, CurrencyCode>: AnyObject {
    associatedtype CurrencyAmount
    associatedtype CurrencyCode
    
    func fromCurrencyArrowTapped()
    func toCurrencyArrowTapped()
    func fromCurrencyValueChanged(amount: CurrencyAmount, code: CurrencyCode)
    func toCurrencyValueChanged(amount: CurrencyAmount, code: CurrencyCode)
    func recalculateButtonTapped()
}

final class HomePresenter: HomePresentable {
    
    typealias CurrencyAmount = Double
    typealias CurrencyCode = String
    
    // MARK: Properties
    var dataStore: CurrencyModuleDataStore? {
        didSet {
            dataStore?.dataUpdated = { [weak self] in
                guard let self else {
                    return
                }
                guard let selectedElement = dataStore?.selectedElement else {
                    return
                }
                switch exchangeDirection {
                case .to:
                    self.toCurrency = selectedElement.currencyCode
                case .from:
                    self.fromCurrency = selectedElement.currencyCode
                }
                self.view?.refreshCurrencies(fromCurrency: self.fromCurrency, toCurrency: self.toCurrency)
                self.convertRequest()
            }
        }
    }
    private weak var view: HomeView?
    private var router: HomeRoutable
    private var networkManager: CurrencyConverterNetworkManager?
    
    
    enum ExchangeDirection {
        case to
        case from
    }
    private var exchangeDirection = ExchangeDirection.from
    private var fromAmount: CurrencyAmount = 0.0
    private var toAmount: CurrencyAmount = 0.0
    private var fromCurrency: CurrencyCode = "USD"
    private var toCurrency: CurrencyCode = "EUR"
    
    init(
        view: HomeView,
        router: HomeRoutable,
        networkManager: CurrencyConverterNetworkManager
    ) {
        self.view = view
        self.router = router
        self.networkManager = networkManager
        
    }
    
    // MARK: - HomePresentable methods
    func fromCurrencyArrowTapped() {
        exchangeDirection = .from
        guard let dataStore else { return }
        router.navigateCurrenciesList(dataStore: dataStore)
    }
    
    func toCurrencyArrowTapped() {
        exchangeDirection = .to
        guard let dataStore else { return }
        router.navigateCurrenciesList(dataStore: dataStore)
    }
    
    func fromCurrencyValueChanged(amount: CurrencyAmount, code: CurrencyCode) {
        exchangeDirection = .from
        fromAmount = amount
        convertRequest()
    }
    
    func toCurrencyValueChanged(amount: CurrencyAmount, code: CurrencyCode) {
        exchangeDirection = .to
        toAmount = amount
        convertRequest()
    }
    
    func recalculateButtonTapped() {
        convertRequest()
    }
    
    // MARK: DataStore protocol methods
    
    func convertRequest() {
        DispatchQueue.main.async {
            self.view?.showLoading()
        }
        Task {
            var amount = 0.0
            var from: CurrencyCode = fromCurrency
            var to: CurrencyCode = toCurrency
            switch exchangeDirection {
            case .from:
                amount = fromAmount
            case .to:
                amount = toAmount
                to = fromCurrency
                from = toCurrency
            }
            do {
                let updateTime = Date().formattedDateTime()
                guard let convertedValue = try await networkManager?.convertCurrency(
                    from: from,
                    to: to,
                    amount: amount
                ) else {
                    return
                }
                DispatchQueue.main.async {
                    switch self.exchangeDirection {
                    case .from:
                        self.toAmount = convertedValue
                        self.view?.refreshAmount(
                            to: self.toAmount > 0 ? self.toAmount.moneyToString() : "",
                            updateTime: updateTime
                        )
                    case .to:
                        self.fromAmount = convertedValue
                        self.view?.refreshAmount(
                            from: self.fromAmount > 0 ? self.fromAmount.moneyToString() : "",
                            updateTime: updateTime
                        )
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.view?.showError(message: error.localizedDescription)
                }
            }
        }
        
    }
}
