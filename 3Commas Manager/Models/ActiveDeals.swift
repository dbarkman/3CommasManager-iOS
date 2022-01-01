//
//  ActiveDeals.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import Foundation

struct ActiveDealData: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    private(set) var activeDealList = [ActiveDeal]()

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var dataContainer = try rootContainer.nestedUnkeyedContainer(forKey: .data)
        while !dataContainer.isAtEnd {
            if let activeDeal = try? dataContainer.decode(ActiveDeal.self) {
                activeDealList.append(activeDeal)
            }
        }
    }
}

struct ActiveDeal: Decodable, Hashable {
    let id: String
}
