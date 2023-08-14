// 
//  HomePresenter.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import Foundation

protocol HomePresentable<CurrencyValue>: AnyObject {
    associatedtype CurrencyValue
    
    func fromCurrencyArrowTapped()
    func toCurrencyArrowTapped()
    func fromCurrencyValueChanged(value: CurrencyValue)
    func toCurrencyValueChanged(value: CurrencyValue)
    func recalculateButtonTapped()
}

final class HomePresenter: HomePresentable, DataStore {
    
    
    typealias CurrencyValue = Double
    var selectedElement: String?
    var elements: [String : String] = [:]
    
    private weak var view: HomeView?
    private var router: HomeRoutable
    private var networkManager: CurrencyConverterNetworkManager?
    
    
    enum ExchangeDirection {
        case to
        case from
    }
    private var exchangeDirection = ExchangeDirection.from
    private var fromValue: CurrencyValue = 0.0
    private var toValue: CurrencyValue = 0.0
    
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
        router.navigateCurrenciesList(dataStore: self)
    }
    
    func toCurrencyArrowTapped() {
        exchangeDirection = .to
        router.navigateCurrenciesList(dataStore: self)
    }
    
    func fromCurrencyValueChanged(value: Double) {
        fromValue = value
        networkManager?.convertCurrency(from: "EUR",
                                        to: "THB",
                                        amount: value,
                                        completion: { response in
                                            switch response {
                                            case .success(let value):
                                                self.toValue = value
                                            case .failure(let error):
                                                print(error)
                                            }
                                        
        }
        )
        updateData()
    }
    
    func toCurrencyValueChanged(value: Double) {
        toValue = value
        updateData()
    }
    
    func recalculateButtonTapped() {
        updateData()
    }
    
    // MARK: DataStore protocol methods
    
    func updateData() {
        let updateTime = getFormattedTime()
        view?.refreshAmounts(
            from: toString(value: fromValue),
            to: toString(value: toValue),
            updateTime: updateTime
        )
    }
    
    // MARK: Private methods
    
    private func toString(value: Double) -> String {
        let stringValue: String
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            stringValue = "\(Int(value))"
        } else {
            stringValue = String(format: "%.2f", value)
        }
        return stringValue
    }
    
    func getFormattedTime() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true
        
        let formattedTime = dateFormatter.string(from: currentDate)
        
        return formattedTime
    }
}
