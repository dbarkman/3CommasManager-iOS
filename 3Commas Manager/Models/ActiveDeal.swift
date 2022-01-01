//
//  ActiveDeal.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import Foundation

struct ActiveDealsData: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    private(set) var activeDealsList = [ActiveDeal]()

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var dataContainer = try rootContainer.nestedUnkeyedContainer(forKey: .data)
        while !dataContainer.isAtEnd {
            if let activeDeals = try? dataContainer.decode(ActiveDeal.self) {
                activeDealsList.append(activeDeals)
            }
        }
    }
}

struct ActiveDeal: Decodable, Hashable {
    let id: String
    let createdAtDateTime: String
    let age: String
    let to_currency: String
    let actual_profit: String
    let actual_profit_percentage: String
    let bought_average_price: String
    let current_price: String
    let take_profit_price: String
    let bot_name: String
    let completed_safety_orders_count: String
    let max_safety_orders: String
}
