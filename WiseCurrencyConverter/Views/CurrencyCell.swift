//
//  CurrencyCell.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 15-08-2023.
//

import UIKit

class CurrencyCell: UITableViewCell, Themed {
    
    // MARK: - Themed Protocol Properties
    
    var theme: ThemeProvider = AppTheme.shared
    
    // MARK: - Properties
    
    static let reuseIdentifier = "CurrencyCellReuseIdentifier"
    static let defaultHeight = 88.0
    private let currencySymbolGenerator = CurrencySymbolGenerator()
    
    // MARK: - UI Properties
    
    @UsingAutoLayout private var currencySymbolLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 32
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor.gray.withAlphaComponent(0.25)
        return label
    }()
    
    @UsingAutoLayout private var currencyCodeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    @UsingAutoLayout private var currencyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        applyTheme()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(currencySymbolLabel)
        contentView.addSubview(currencyCodeLabel)
        contentView.addSubview(currencyLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            currencySymbolLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            currencySymbolLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            currencySymbolLabel.widthAnchor.constraint(equalToConstant: 64),
            currencySymbolLabel.heightAnchor.constraint(equalToConstant: 64),
            
            currencyCodeLabel.leadingAnchor.constraint(equalTo: currencySymbolLabel.trailingAnchor, constant: 16),
            currencyCodeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            currencyCodeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            
            currencyLabel.leadingAnchor.constraint(equalTo: currencySymbolLabel.trailingAnchor, constant: 16),
            currencyLabel.topAnchor.constraint(equalTo: currencyCodeLabel.bottomAnchor, constant: 4),
            currencyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Public Methods
    
    func setup(with currency: Currency) {
        currencyCodeLabel.text = currency.currencyCode
        currencyLabel.text = currency.currencyName
        let currencySymbol = currencySymbolGenerator.getCurrencySymbol(for: currency.currencyCode)
        currencySymbolLabel.text = currencySymbol.symbol
        currencySymbolLabel.font = currencySymbol.isEmoji ? theme.symbolFont : theme.switcherFont
    }
    
    // MARK: Themed Protocol Methods
    
    func applyTheme() {
        backgroundColor = theme.mainBackgroundColor
        currencySymbolLabel.font = theme.symbolFont
        currencyCodeLabel.font = theme.switcherFont
        currencyLabel.font = theme.bodyFont
    }

    
}
