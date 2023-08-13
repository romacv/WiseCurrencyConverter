//
//  CurrencyInputView.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import UIKit

protocol CurrencyViewDelegate: AnyObject {
    func didSelectCurrency()
}

class CurrencyInputView: UIView, Themed {
    
    // MARK: - UI Elements
    
    @UsingAutoLayout private var textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.placeholder = "0.00"
        return textField
    }()
    
    @UsingAutoLayout private var currencyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    @UsingAutoLayout private var currencyLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    @UsingAutoLayout private var currencyCodeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    @UsingAutoLayout private var arrowDownImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.down"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    // MARK: - Properties
    var arrowTappedHandler: (() -> Void)?
    var numberValueChangedHandler: ((Double) -> Void)?
    private var currencyInputDelegate = CurrencyInputDelegate()
    var theme: ThemeProvider = AppTheme.shared
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        setupConstraints()
        applyBorder()
        setupGestureRecognizer()
        currencyInputDelegate.valueChangedHandler = { [weak self] value in
            let doubleValue = Double(value) ?? 0.0
            self?.numberValueChangedHandler?(doubleValue)
        }
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        addSubview(textField)
        addSubview(currencyStackView)
        
        textField.delegate = currencyInputDelegate
        
        currencyStackView.addArrangedSubview(currencyLogoImageView)
        currencyStackView.addArrangedSubview(currencyCodeLabel)
        currencyStackView.addArrangedSubview(arrowDownImageView)
        
        applyTheme(theme: theme)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // TextField
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -2),
            
            // Currency Stack View
            // setup resistance for currencyStackView
            currencyStackView.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8),
            currencyStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            currencyStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            currencyStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            currencyCodeLabel.widthAnchor.constraint(equalToConstant: 44),
            currencyLogoImageView.widthAnchor.constraint(equalTo: currencyLogoImageView.heightAnchor),
            arrowDownImageView.widthAnchor.constraint(equalToConstant: 16)
        ])
        
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .vertical)
        currencyStackView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        currencyStackView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    private func applyBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 8
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Event Handler
    
    @objc private func handleTapGesture() {
        arrowTappedHandler?()
    }
    
    // MARK: - Public Methods
    
    func setupCurrency(code: String, logo: UIImage?) {
        currencyCodeLabel.text = code
        currencyLogoImageView.image = logo
    }
    
    func setupTextfieldValue(value: String) {
        textField.text = value
    }
    
    // MARK: - Themed methods
    
    func applyTheme(theme: ThemeProvider) {
        textField.font = theme.inputFont
        currencyCodeLabel.font = theme.switcherFont
    }
}
