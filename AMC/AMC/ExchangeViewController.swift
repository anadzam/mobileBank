//
//  ExchangeViewController.swift
//  AMC
//
//  Created by Ana Dzamelashvili on 2/21/22.
//

import UIKit



class ExchangeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   

    private var viewModels = [CurrTableViewCellViewModel]()
   

    let headers = [
     "Accept": "application/json",
     "apikey": "6PjcgamsfwEVZk6ULCiwKRoHJef2dAyg"
    ]
    

    var activeCurrency = 0.0
//

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var label: UILabel!
   
    
    var CurrencyNameList = [
    "AED", "AMD", "AVD", "AZN", "BGN", "CAD", "CHF", "CNY", "CZK", "DKK", "EUR", "GBP", "ILS", "JPY", "NOK", "PLN", "QAR", "RUR", "SAR", "SEK", "TRY", "UKG", "USD"
    ]
    
    var values = [0.7590, 0.0047, 2.0060,1.4130,1.3680, 2.2170,3.1470, 0.4203, 0.1310, 0.4260, 3.2980, 3.9740, 0.8788, 0.0243,0.3090, 0.6950,  0.5140, 0.0362,0.7320, 0.2970, 0.1980, 0.0750, 2.9300
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.endEditing(false)
        pickerView.delegate = self
        pickerView.dataSource = self
        RatesAPICaller()
        GetallRatesData()
        
        textField.addTarget(self, action: #selector(updateViews), for: .editingChanged)
    }
    
    @objc func updateViews(input: Double) {
        label.text = nil
        guard let amountText = textField.text, let theAmountText = Double(amountText) else {
            return
        }
        if textField.text != "" {
            let total = theAmountText * activeCurrency
            label.text = String(format: "%.2f", total)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        CurrencyNameList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        CurrencyNameList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
     
        activeCurrency = values[row]
        updateViews(input: activeCurrency)
    }
    
    
       func GetallRatesData() {
      let request = NSMutableURLRequest(url: NSURL(string: "https://api.tbcbank.ge/v1/exchange-rates/commercial?currency")! as URL,
                          cachePolicy: .useProtocolCachePolicy,
                          timeoutInterval: 10.0)
      request.httpMethod = "GET"
      request.allHTTPHeaderFields = headers
          let dataTask = URLSession.shared.dataTask(with: request as URLRequest){data, response, error in
            guard let data = data, error == nil else {
    //          print ("Error")
              return
                
            }
            do {
                
                let rates = try JSONDecoder().decode(Response.self, from: data)
                let RatesData = rates.CurrencyRates
//                completion(.success(RatesData))
                print(RatesData)
                
                
                DispatchQueue.main.async {
                    self.pickerView.reloadAllComponents()
                }
                
                //Decode response
    //          let decoder = JSONDecoder()
    //          let decoded = try decoder.decode(Response.self, from: jsonData)
    //          completion(decoded.CurrencyRates)
            }
              catch {
                  print(error)
//                completion(.failure(error))
            }
              
              
          }
          dataTask.resume()
     }
    }



    

    
//    func fetchJSON() {
//        guard let url = URL(string: "https://open.er-api.com/v6/latest/USD") else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if error != nil {
//               print(error!)
//                return
//            }
//
//            guard let safeData = data else {
//                return
//            }
//
//            do {
//                let results = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
//                print(results.rates)
//            }
//            catch {
//                print(error)
//
//            }
//        }.resume()
//    }
//
//}
