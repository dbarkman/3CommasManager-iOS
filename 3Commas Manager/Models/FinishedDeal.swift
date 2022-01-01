//
//  FinishedDeal.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import Foundation

struct FinishedDealsData: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    private(set) var finishedDealsList = [FinishedDeal]()

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var dataContainer = try rootContainer.nestedUnkeyedContainer(forKey: .data)
        while !dataContainer.isAtEnd {
            if let finishedDeals = try? dataContainer.decode(FinishedDeal.self) {
                finishedDealsList.append(finishedDeals)
            }
        }
    }
}

struct FinishedDeal: Decodable, Hashable {
    let id: String
    let closedAtDateTime: String
    let age: String
    let to_currency: String
    let final_profit: String
    let final_profit_percentage: String
    let bot_name: String
    let completed_safety_orders_count: String
    let max_safety_orders: String
}
