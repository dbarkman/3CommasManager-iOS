//
//  Stats.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import Foundation

struct StatsData: Decodable {
    
    private enum RootCodingKeys: String, CodingKey {
        case data
    }
    
    private(set) var stats: Stats
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let dataContainer = try rootContainer.decode(Stats.self, forKey: .data)
        self.stats = dataContainer
    }
}

struct Stats: Decodable, Hashable {
    var currentActiveDealsCount: String?
    var dealsClosedTodayCount: String?
    var totalClosedDealCount: String?
    var dealsClosedNoSafetyOrdersPercent: String?
    var dealsClosedSomeSafetyOrdersPercent: String?
    var dealsClosedMaxSafetyOrdersPercent: String?
    var todaysProfit: String?
    var totalProfit: String?
    var averageProfit: String?
    var averageActiveAge: String?
    var todayAverageCloseAge: String?
    var totalAverageCloseAge: String?
    var fearGreedIndex: String?
    var portfolioBalance: Double?
    var portfolioChangePercent: String?
    var daysTradingCount: String?
    var averageDailyClosedCount: String?
    var averageDailyClosedProfit: String?
    var bagsCount: String?
    var bagsAmount: String?
    var oldestBag: String?
    var activeBots: String?
    var mostTradedAsset: String?
    var largestDeal: String?
    var bitcoinTicker: String?
    var ethereumTicker: String?
    var dogecoinTicker: String?
}
