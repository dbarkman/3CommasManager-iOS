//
//  Asset.swift
//  3Commas Manager
//
//  Created by David Barkman on 1/1/22.
//

import Foundation

struct AssetsData: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    private(set) var assetsList = [Asset]()

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        var dataContainer = try rootContainer.nestedUnkeyedContainer(forKey: .data)
        while !dataContainer.isAtEnd {
            if let assets = try? dataContainer.decode(Asset.self) {
                assetsList.append(assets)
            }
        }
    }
}

struct Asset: Decodable, Hashable {
    let id: String
    let symbol: String
    let profit: String
    let deals: String
    let averageProfit: String
}
