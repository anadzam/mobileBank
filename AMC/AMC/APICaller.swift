//
//  APICaller.swift
//  AMC
//
//  Created by Ana Dzamelashvili on 2/9/22.
//

import Foundation

final class APICaller {
    static let shared  = APICaller()
    
    private struct Constants {
        static let apiKey = "A2B97FF1-AC09-4C7E-9BAB-B5BD95D54C99"
        static let assetsEndpoint = "http://rest-sandbox.coinapi.io/v1/assets/"
    }
    
    private init() {}
    
    //public
    
    public func getAllCryptoData(
        completion: @escaping (Result<[Crypto], Error>) -> Void
    ) {
        guard let url = URL(string: Constants.assetsEndpoint + "?apikey=" + Constants.apiKey) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                //decode response
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                // sorts by greatest price first
                //                cryptos.sorted { first, second -> Bool in
                //                    return first.price_usd ?? 0 > second.price_usd ?? 0
                //                }
                completion(.success(cryptos.sorted { first, second -> Bool in
                    return first.price_usd ?? 0 > second.price_usd ?? 0
                }))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
    
}
