// 
//  HomeVC.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import UIKit

protocol HomeView: AnyObject {
    func refreshAmounts(from: String, to: String, updateTime: String)
}

import UIKit

final class HomeVC: UIViewController, HomeView {
    
    // MARK: Properties
    typealias CurrencyValue = Double
    var presenter: (any HomePresentable<CurrencyValue>)!
    var theme: ThemeProvider!
    
    private var recalculateButtonBottomConstraint: NSLayoutConstraint!
    private var recalculateButtonLeftConstraint: NSLayoutConstraint!
    private var recalculateButtonRightConstraint: NSLayoutConstraint!
    
    // MARK: - UI Elements
    
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
        
        let dollarImage = UIImage(systemName: "dollarsign.circle.fill")
        fromCurrencyInputView.setupCurrency(code: "USD", logo: dollarImage)
        
        let euroImage = UIImage(systemName: "eurosign.circle.fill")
        toCurrencyInputView.setupCurrency(code: "EUR", logo: euroImage)
        
        
        addKeyboardObservers()
    }
    
    // MARK: - HomeVC Protocol
    func refreshAmounts(from: String, to: String, updateTime: String) {
        fromCurrencyInputView.setupTextfieldValue(value: from)
        toCurrencyInputView.setupTextfieldValue(value: to)
        updatedAtLabel.text = "Updated at: \(updateTime)"
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
        
        titleLabel.font = theme.titleFont
        fromLabel.font = theme.hintFont
        toLabel.font = theme.hintFont
        updatedAtLabel.font = theme.bodyFont
        fromCurrencyInputView.theme = theme
        toCurrencyInputView.applyTheme(theme: theme)
        recalculateButton.applyTheme(theme: theme)
        
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
        
        fromCurrencyInputView.numberValueChangedHandler = { [weak self] value in
            self?.presenter.fromCurrencyValueChanged(value: value)
        }
        
        toCurrencyInputView.numberValueChangedHandler = { [weak self] value in
            self?.presenter.toCurrencyValueChanged(value: value)
        }
        
        
        
    }
    
    private func setupConstraints() {
        recalculateButtonBottomConstraint = recalculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        recalculateButtonBottomConstraint.isActive = true
        recalculateButtonLeftConstraint = recalculateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        recalculateButtonLeftConstraint.isActive = true
        recalculateButtonRightConstraint = recalculateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        recalculateButtonRightConstraint.isActive = true
        
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
    
    private func addKeyboardObservers() {
        addKeyboardObservers(
            keyboardWillShow: { [weak self] keyboardFrame in
                guard let self = self else { return }
                let keyboardIntersection = self.view.frame.intersection(keyboardFrame)
                let buttonBottomInset = keyboardIntersection.height
                recalculateButtonBottomConstraint.constant = -buttonBottomInset + self.view.safeAreaInsets.bottom
                recalculateButtonBottomConstraint.isActive = true
                recalculateButtonLeftConstraint.constant = 0
                recalculateButtonLeftConstraint.isActive = true
                recalculateButtonRightConstraint.constant = 0
                recalculateButtonRightConstraint.isActive = true
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
                recalculateButtonBottomConstraint.isActive = true
                recalculateButtonLeftConstraint.constant = 16
                recalculateButtonLeftConstraint.isActive = true
                recalculateButtonRightConstraint.constant = -16
                recalculateButtonRightConstraint.isActive = true
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
}
