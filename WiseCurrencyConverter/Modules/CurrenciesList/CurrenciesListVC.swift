// 
//  CurrenciesListVC.swift
//  WiseCurrencyConverter
//
//  Created by Roman Resenchuk on 10-08-2023.
//

import UIKit

protocol CurrenciesListVCProtocol: AnyObject {
    
}

final class CurrenciesListVC: UIViewController, CurrenciesListVCProtocol {
    
    var presenter: CurrenciesListPresenterProtocol!
    
    // Step 1: Add a table view to your view controller's view
    
    private var tableView: UITableView!
    private let items = ["1", "2", "3", "4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Step 1: Initialize the table view and add it to the view controller's view
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register a cell class or nib if needed
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellReuseIdentifier")
        
        view.addSubview(tableView)
    }
}

// Step 2: Conform to UITableViewDataSource

extension CurrenciesListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellReuseIdentifier", for: indexPath)
        
        // Configure the cell with the item at the corresponding index
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
}

extension CurrenciesListVC: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            presenter.didSelectItem(index: UInt(indexPath.row))
        }
    
}
