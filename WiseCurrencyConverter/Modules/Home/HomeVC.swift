// 
//  HomeVC.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import UIKit

protocol HomeView: AnyObject {
    func refreshCurrencies(fromCurrency: String, toCurrency: String)
    func refreshAmount(from: String, updateTime: String)
    func refreshAmount(to: String, updateTime: String)
    func showError(message: String)
    func showLoading()
}

import UIKit

final class HomeVC: UIViewController, HomeView, Themed {
    
    // MARK: - Themed Protocol Properties
    
    var theme: ThemeProvider = AppTheme.shared
    
    // MARK: - Properties
    
    typealias CurrencyAmount = Double
    typealias CurrencyCode = String
    var presenter: (any HomePresentable<CurrencyAmount, CurrencyCode>)!
    
    private var recalculateButtonBottomConstraint: NSLayoutConstraint!
    private var recalculateButtonLeftConstraint: NSLayoutConstraint!
    private var recalculateButtonRightConstraint: NSLayoutConstraint!
    
    // MARK: - UI Properties
    
    @UsingAutoLayout private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Currency Converter"
        label.textAlignment = .left
        return label
    }()
    
    @UsingAutoLayout private var fromLabel: UILabel = {
        let label = UILabel()
        label.text = "From"
        label.textColor = .black
        return label
    }()
    
    @UsingAutoLayout private var fromCurrencyInputView: CurrencyInputView = {
        let view = CurrencyInputView()
        view.textFieldAccessibilityIdentifier = "FromCurrencyTextField"
        view.currencyStackViewAccessibilityIdentifier = "FromCurrencyView"
        return view
    }()

    
    @UsingAutoLayout private var toLabel: UILabel = {
        let label = UILabel()
        label.text = "To"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .black
        return label
    }()
    
    @UsingAutoLayout private var toCurrencyInputView: CurrencyInputView = {
        let view = CurrencyInputView()
        view.textFieldAccessibilityIdentifier = "ToCurrencyTextField"
        view.currencyStackViewAccessibilityIdentifier = "ToCurrencyView"
        return view
    }()
    
    @UsingAutoLayout private var updatedAtLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    @UsingAutoLayout private var recalculateButton: BottomButton = {
        let button = BottomButton()
        return button
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addKeyboardObservers()
        applyTheme()
    }
    
    // MARK: - HomeView Protocol
    
    func refreshCurrencies(fromCurrency: String, toCurrency: String) {
        fromCurrencyInputView.setupCurrency(code: fromCurrency)
        toCurrencyInputView.setupCurrency(code: toCurrency)
    }
    
    func refreshAmount(from: String, updateTime: String) {
        fromCurrencyInputView.setupTextfieldValue(value: from)
        updatedAtLabel.text = "Updated at: \(updateTime)"
        recalculateButton.loading(isActive: false)
    }
    
    func refreshAmount(to: String, updateTime: String) {
        toCurrencyInputView.setupTextfieldValue(value: to)
        updatedAtLabel.text = "Updated at: \(updateTime)"
        recalculateButton.loading(isActive: false)
    }
    
    func showError(message: String) {
        recalculateButton.loading(isActive: false)
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "Ok",
            style: .cancel
        )
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func showLoading() {
        recalculateButton.loading(isActive: true)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = .white
        recalculateButton.setupText("Recalculate")
        view.addSubview(titleLabel)
        view.addSubview(fromLabel)
        view.addSubview(fromCurrencyInputView)
        view.addSubview(toLabel)
        view.addSubview(toCurrencyInputView)
        view.addSubview(updatedAtLabel)
        view.addSubview(recalculateButton)
        setupConstraints()
        recalculateButton.updateAppearance(for: .enabled, isRounded: true)
        recalculateButton.buttonTappedHandler = { [weak self] in
            self?.presenter.recalculateButtonTapped()
        }
        fromCurrencyInputView.arrowTappedHandler = { [weak self] in
            self?.presenter.fromCurrencyArrowTapped()
        }
        toCurrencyInputView.arrowTappedHandler = { [weak self] in
            self?.presenter.toCurrencyArrowTapped()
        }
        fromCurrencyInputView.numberValueChangedHandler = { [weak self] amount, code in
            self?.presenter.fromCurrencyValueChanged(amount: amount, code: code)
        }
        toCurrencyInputView.numberValueChangedHandler = { [weak self] amount, code in
            self?.presenter.toCurrencyValueChanged(amount: amount, code: code)
        }
        fromCurrencyInputView.setupCurrency(code: "USD")
        toCurrencyInputView.setupCurrency(code: "EUR")
    }
    
    private func setupConstraints() {
        recalculateButtonBottomConstraint = recalculateButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -16
        )
        recalculateButtonLeftConstraint = recalculateButton.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 16
        )
        recalculateButtonRightConstraint = recalculateButton.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: -16
        )
        _ = [
            recalculateButtonLeftConstraint,
            recalculateButtonBottomConstraint,
            recalculateButtonRightConstraint
        ].map({ $0?.isActive = true })
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fromLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            fromLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fromCurrencyInputView.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 8),
            fromCurrencyInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fromCurrencyInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            fromCurrencyInputView.heightAnchor.constraint(equalToConstant: 64),
            toLabel.topAnchor.constraint(equalTo: fromCurrencyInputView.bottomAnchor, constant: 32),
            toLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            toCurrencyInputView.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 8),
            toCurrencyInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            toCurrencyInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            toCurrencyInputView.heightAnchor.constraint(equalToConstant: 64),
            updatedAtLabel.bottomAnchor.constraint(equalTo: recalculateButton.topAnchor, constant: -16),
            updatedAtLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            updatedAtLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            recalculateButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
    
    // MARK: - Private Methods
    private func addKeyboardObservers() {
        addKeyboardObservers(
            keyboardWillShow: { [weak self] keyboardFrame in
                guard let self = self else { return }
                let keyboardIntersection = self.view.frame.intersection(keyboardFrame)
                let buttonBottomInset = keyboardIntersection.height
                recalculateButtonBottomConstraint.constant = -buttonBottomInset + self.view.safeAreaInsets.bottom
                recalculateButtonLeftConstraint.constant = 0
                recalculateButtonRightConstraint.constant = 0
                _ = [
                    recalculateButtonLeftConstraint,
                    recalculateButtonBottomConstraint,
                    recalculateButtonRightConstraint
                ].map({ $0?.isActive = true })
                UIView.animate(withDuration: 0.3) {
                    self.recalculateButton.updateAppearance(
                        for: .enabled,
                        isRounded: false
                    )
                    self.view.layoutIfNeeded()
                }
            },
            keyboardWillHide: { [weak self] in
                guard let self = self else { return }
                recalculateButtonBottomConstraint.constant = -16
                recalculateButtonLeftConstraint.constant = 16
                recalculateButtonRightConstraint.constant = -16
                _ = [
                    recalculateButtonLeftConstraint,
                    recalculateButtonBottomConstraint,
                    recalculateButtonRightConstraint
                ].map({ $0?.isActive = true })
                UIView.animate(withDuration: 0.3) {
                    self.recalculateButton.updateAppearance(
                        for: .enabled,
                        isRounded: true
                    )
                    self.view.layoutIfNeeded()
                }
            }
        )
    }
    
    // MARK: Themed Protocol methods
    func applyTheme() {
        titleLabel.font = theme.titleFont
        fromLabel.font = theme.hintFont
        toLabel.font = theme.hintFont
        updatedAtLabel.font = theme.bodyFont
    }
}
