
//  currAPICaller.swift
//  AMC
//
//  Created by Ana Dzamelashvili on 2/15/22.


import Foundation

final class RatesAPICaller {
    static let shared  = RatesAPICaller()
     init() {}
let headers = [
 "Accept": "application/json",
 "apikey": "6PjcgamsfwEVZk6ULCiwKRoHJef2dAyg"
]
 public func GetallRatesData(completion: @escaping (Result<[Rates], Error>) -> Void ) {
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
            completion(.success(RatesData))
            
            //Decode response
//          let decoder = JSONDecoder()
//          let decoded = try decoder.decode(Response.self, from: jsonData)
//          completion(decoded.CurrencyRates)
        }
          catch {
            completion(.failure(error))
        }
          
          
      }
      dataTask.resume()
 }
}



