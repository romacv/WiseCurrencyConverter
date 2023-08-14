// 
//  CurrenciesListVC.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import UIKit

protocol CurrenciesListVCProtocol: AnyObject {
    func refreshTable()
    func showError(message: String)
}

final class CurrenciesListVC: UIViewController, CurrenciesListVCProtocol {
    func refreshTable() {
        tableView.reloadData()
    }
    
    func showError(message: String) {
        
    }
    
    
    var presenter: CurrenciesListPresentable!
    
    // Step 1: Add a table view to your view controller's view
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Step 1: Initialize the table view and add it to the view controller's view
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register a cell class or nib if needed
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellReuseIdentifier")
        
        view.addSubview(tableView)
        
        presenter.fetchCurrencies()
    }
}

// Step 2: Conform to UITableViewDataSource

extension CurrenciesListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.itemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellReuseIdentifier", for: indexPath)
        let items = presenter.items()
                let keys = Array(items.keys)
                
                let currencyKey = keys[indexPath.row]
                let currencyValue = items[currencyKey]
                
                cell.textLabel?.text = "\(currencyKey): \(currencyValue ?? "")"
                
                return cell
        
        return cell
    }
}

extension CurrenciesListVC: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            presenter.didSelectItem(index: Int(indexPath.row))
        }
    
}
