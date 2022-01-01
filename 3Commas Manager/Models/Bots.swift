//
//  Bots.swift
//  3Commas Manager
//
//  Created by David Barkman on 1/1/22.
//

import Foundation

struct BotsData: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    private(set) var botsList = [Bot]()

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var dataContainer = try rootContainer.nestedUnkeyedContainer(forKey: .data)
        while !dataContainer.isAtEnd {
            if let bots = try? dataContainer.decode(Bot.self) {
                botsList.append(bots)
            }
        }
    }
}

struct Bot: Decodable, Hashable {
    let id: String
    let bot: String
    let account: String
    let type: String
    let totalProfit: String
    let averageProfit: String
}
