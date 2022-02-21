//
//  CurrencyViewController.swift
//  AMC
//
//  Created by Ana Dzamelashvili on 2/18/22.
//

import UIKit
import FirebaseAuth


class CurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CurrTableViewCell.self, forCellReuseIdentifier: CurrTableViewCell.identifier)
        return tableView
        
        
    }()
    
    private var viewModels = [CurrTableViewCellViewModel]()
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .default
        
        return formatter
    }()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       
    

        
        
        view.addSubview(tableView)
//        title = "Currency"
        tableView.delegate = self
        tableView.dataSource = self
       
        
        RatesAPICaller.shared.GetallRatesData { [weak self] result in
            switch result {
            case .success(let models):
                self?.viewModels = models.compactMap({
                    //numberFormatter
                    
                    let buyPrice = $0.buy ?? 0
                    let sellPrice = $0.sell ?? 0
                    let formatter = CurrencyViewController.numberFormatter
                    let buyPriceString = formatter.string(from: NSNumber(value: buyPrice))
                    let sellPriceString = formatter.string(from: NSNumber(value: sellPrice))
                    
                    return CurrTableViewCellViewModel(currency: $0.currency,
                                               buyPrice: buyPriceString ?? "N/A",
                                               sellPrice: sellPriceString ?? "N/A")
                })
                
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let CurCell = tableView.dequeueReusableCell(withIdentifier: CurrTableViewCell.identifier, for: indexPath) as? CurrTableViewCell else {
           fatalError()
        }
        
        CurCell.configure(with: viewModels[indexPath.row])
        return CurCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       70
    }
   
    
}





//
//class CurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    private let tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.register(CurrTableViewCell.self, forCellReuseIdentifier: CurrTableViewCell.identifier)
//
//        return tableView
//
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(tableView)
//        tableView.dataSource = self
//        tableView.delegate = self
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        tableView.bounds = view.bounds
//    }
//    
//    //TableView
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 23
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       guard let prototype = tableView.dequeueReusableCell(withIdentifier: CurrTableViewCell.identifier , for: indexPath) as? CurrTableViewCell else {
//            fatalError()
//        }
//        prototype.textLabel?.text = "Hello World"
//        
//        return prototype
//    }
//}
//class CurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//
//    let CurTableView = UITableView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(CurTableView)
//
//        CurTableView.register(UITableViewCell.self, forCellReuseIdentifier: "curCell")
//        CurTableView.delegate = self
//        CurTableView.dataSource = self
//
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        CurTableView.frame = view.bounds
//
//    }
//
//    func tableView(_ CurTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 23
//    }
//
//    func tableView(_ CurTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let curCell = CurTableView.dequeueReusableCell(withIdentifier: "curCell", for: indexPath)
//
//        curCell.textLabel?.text = "Cell \(indexPath.row + 1)"
//
//        return curCell
//    }
//
//}
