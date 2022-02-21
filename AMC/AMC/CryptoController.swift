//
//  CryptoController.swift
//  AMC
//
//  Created by Ana Dzamelashvili on 2/9/22.
//

import UIKit
import FirebaseAuth

//API caller



class CryptoController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
//    let searchController = UISearchController(searchResultsController: nil)
    //    var dataArray = [String]()
//        var filteredArray = [String]()
//        var shouldShowSearchResults = false
  
  

    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        
        return tableView
        
    }()
     
    
    private var viewModels = [CryptoTableViewCellViewModel]()
   

    
    static let numberFormatter: NumberFormatter = {
        
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .default
        
        return formatter
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        
//        searchController.obscuresBackgroundDuringPresentation = false
//       
//        
//        navigationItem.searchController = searchController
//        searchController.searchResultsUpdater = self
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        //searchBar.delegate = self
        
        
        APICaller.shared.getAllCryptoData { [weak self] result in
            switch result {
            case.success(let models):
                self?.viewModels = models.compactMap({
                    
                    //numberFormatter
                    
                    let price = $0.price_usd ?? 0
                    let formatter = CryptoController.numberFormatter
                    let priceString = formatter.string(from: NSNumber(value: price))
                    
                   return CryptoTableViewCellViewModel(name: $0.name ?? "N/A",
                                                 symbol: $0.asset_id,
                                                 price: priceString ?? "N/A"
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case.failure(let error):
                print("Error: \(error)")
            }
            
        }
        
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let textResult = searchController.searchBar.text else {
            
            return
        }
       
        print(textResult)
    }
    //tableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else {
            fatalError()
        }
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}


