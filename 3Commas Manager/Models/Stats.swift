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
  var currentActiveDealsCount = "0"
  var dealsClosedTodayCount = "0"
  var totalClosedDealCount = "0"
  var todaysProfit = "0.00"
  var totalProfit = "0.00"
  var daysTradingCount = "0"
  var averageDailyClosedCount = "0"
  var averageProfit = "0.00"
  var averageDailyClosedProfit = "0.00"
  var todayAverageCloseAge = "0"
  var averageActiveAge = "0"
  var totalAverageCloseAge = "0"
  var dealsClosedNoSafetyOrdersPercent = "0.00"
  var dealsClosedSomeSafetyOrdersPercent = "0.00"
  var dealsClosedMaxSafetyOrdersPercent = "0.00"
  var bagsCount = "0"
  var bagsAmount = "0.00"
  var biggestBag = "0.00"
  var activeBots = "0"
  var mostTradedAsset = "BTC: 0"
  var largestDeal = "BTC: $0.00"
  var portfolioBalance = "0.00"
  var portfolioChangePercent = "0.00"
  var usdtAvailable = "0.00"
  var fearGreedIndex = "0"
  var bitcoinTicker = "0.00"
  var ethereumTicker = "0.00"
  var dogecoinTicker = "0.00"
}
