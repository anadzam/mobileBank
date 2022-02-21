//
//  models.swift
//  AMC
//
//  Created by Ana Dzamelashvili on 2/9/22.
//

import Foundation
//for Crypto
struct Crypto: Codable {
    let asset_id: String
    let name: String?
    let price_usd: Float?
    let id_icon: String?
}


// For Currency
struct Rates: Codable {
  let currency: String
  let sell: Float?
  let buy: Float?

}

struct Response: Codable {
  let CurrencyRates: [Rates]
  enum CodingKeys: String, CodingKey{
    case CurrencyRates = "commercialRatesList"
  }
}


//struct ExchangeRates: Codable {
//    let rates: [String: Double]
//}
