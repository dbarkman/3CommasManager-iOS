//
//  StatsView.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import SwiftUI

struct StatsView: View {
  
//  var statsProvider: StatsProvider = .shared
  
  @ObservedObject var statsProvider = StatsProvider()
//  @State private var stats = statsProvider.stats
  
  @State private var stats = Stats()
  @State private var account = "real"
//  @State private var currentActiveDealsCount = ""
  @State private var dealsClosedTodayCount = ""
  @State private var totalClosedDealCount = ""
  @State private var dealsClosedNoSafetyOrdersPercent = ""
  @State private var dealsClosedSomeSafetyOrdersPercent = ""
  @State private var dealsClosedMaxSafetyOrdersPercent = ""
  @State private var todaysProfit = ""
  @State private var totalProfit = ""
  @State private var averageProfit = ""
  @State private var averageActiveAge = ""
  @State private var todayAverageCloseAge = ""
  @State private var totalAverageCloseAge = ""
  @State private var fearGreedIndex = ""
  @State private var portfolioBalance = ""
  @State private var portfolioChangePercent = ""
  @State private var daysTradingCount = ""
  @State private var averageDailyClosedCount = ""
  @State private var averageDailyClosedProfit = ""
  @State private var bagsCount = ""
  @State private var bagsAmount = ""
  @State private var oldestBag = ""
  @State private var activeBots = ""
  @State private var mostTradedAsset = ""
  @State private var largestDeal = ""
  @State private var bitcoinTicker = ""
  @State private var ethereumTicker = ""
  @State private var dogecoinTicker = ""
  
  var body: some View {
    NavigationView {
      Form {
        
      }
      List {
        Group {
          HStack {
            Text("Current Active Deals")
            Spacer()
            Text(statsProvider.stats.currentActiveDealsCount)
          }
          HStack {
            Text("Deals Closed Today")
            Spacer()
            Text(dealsClosedTodayCount)
          }
          HStack {
            Text("Total Deals Closed")
            Spacer()
            Text(totalClosedDealCount)
          }
          HStack {
            Text("Today's Profit")
            Spacer()
            Text("$\(todaysProfit)")
          }
          HStack {
            Text("Total Profit")
            Spacer()
            Text("$\(totalProfit)")
          }
          HStack {
            Text("Days Trading")
            Spacer()
            Text("\(daysTradingCount) days")
          }
          HStack {
            Text("Average Deals Closed Daily")
            Spacer()
            Text(averageDailyClosedCount)
          }
          HStack {
            Text("Average Deal Profit")
            Spacer()
            Text("$\(averageProfit)")
          }
          HStack {
            Text("Average Daily Profit")
            Spacer()
            Text("$\(averageDailyClosedProfit)")
          }
        }
        Group {
          HStack {
            Text("Average Age Closed Today")
            Spacer()
            Text("\(todayAverageCloseAge) hours")
          }
          HStack {
            Text("Average Active Age")
            Spacer()
            Text("\(averageActiveAge) hours")
          }
          HStack {
            Text("Average Age All Close")
            Spacer()
            Text("\(totalAverageCloseAge) hours")
          }
          HStack {
            Text("Deals Closed w/No SOs")
            Spacer()
            Text("\(dealsClosedNoSafetyOrdersPercent)%")
          }
          HStack {
            Text("Deals Closed w/Some SOs")
            Spacer()
            Text("\(dealsClosedSomeSafetyOrdersPercent)%")
          }
          HStack {
            Text("Deals Closed w/Max SOs")
            Spacer()
            Text("\(dealsClosedMaxSafetyOrdersPercent)%")
          }
          HStack {
            Text("Bags, older than 72 hours")
            Spacer()
            Text(bagsCount)
          }
          HStack {
            Text("Bags Total Cost")
            Spacer()
            Text("$\(bagsAmount)")
          }
          HStack {
            Text("Oldest Bag")
            Spacer()
            Text("\(oldestBag) hours")
          }
        }
        Group {
          HStack {
            Text("Active Bots")
            Spacer()
            Text(activeBots)
          }
          HStack {
            Text("Most Traded Asset")
            Spacer()
            Text(mostTradedAsset)
          }
          HStack {
            Text("Largest Deal")
            Spacer()
            Text(largestDeal)
          }
          HStack {
            Text("Portfolio Balance")
            Spacer()
            Text("$\(portfolioBalance)")
          }
          HStack {
            Text("Portfolio Change")
            Spacer()
            Text("\(portfolioChangePercent)%")
          }
          HStack {
            Text("Fear & Greed Index")
            Spacer()
            Text(fearGreedIndex)
          }
          HStack {
            Text("Bitcoin")
            Spacer()
            Text("$\(bitcoinTicker)0")
          }
          HStack {
            Text("Ethereum")
            Spacer()
            Text("$\(ethereumTicker)")
          }
          HStack {
            Text("Dogecoin")
            Spacer()
            Text("$\(dogecoinTicker)")
          }
        }
      }
      .task {
        await loadStats(account: account)
      }
      .refreshable {
        await loadStats(account: account)
      }
      .navigationTitle("Stats")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(account.capitalized) {
            Task {
              await loadOtherAccount()
            }
          }
        }
      }
    }
  }
  
  private func loadOtherAccount() async {
    if account == "real" {
      account = "paper"
      await loadStats(account: "paper")
    } else if account == "paper" {
      account = "real"
      await loadStats(account: "real")
    }
  }
  
  private func loadStats(account: String) async {
    do {
      try await statsProvider.fetchStats(account: account)
//      stats = try await statsProvider.fetchStats(account: account)
//      if let currentActiveDealsCount = statsProvider.stats.currentActiveDealsCount,
      if let dealsClosedTodayCount = statsProvider.stats.dealsClosedTodayCount,
         let totalClosedDealCount = statsProvider.stats.totalClosedDealCount,
         let dealsClosedNoSafetyOrdersPercent = statsProvider.stats.dealsClosedNoSafetyOrdersPercent,
         let dealsClosedSomeSafetyOrdersPercent = statsProvider.stats.dealsClosedSomeSafetyOrdersPercent,
         let dealsClosedMaxSafetyOrdersPercent = statsProvider.stats.dealsClosedMaxSafetyOrdersPercent,
         let todaysProfit = statsProvider.stats.todaysProfit,
         let totalProfit = statsProvider.stats.totalProfit,
         let averageProfit = statsProvider.stats.averageProfit,
         let averageActiveAge = statsProvider.stats.averageActiveAge,
         let todayAverageCloseAge = statsProvider.stats.todayAverageCloseAge,
         let totalAverageCloseAge = statsProvider.stats.totalAverageCloseAge,
         let fearGreedIndex = statsProvider.stats.fearGreedIndex,
         let portfolioBalance = statsProvider.stats.portfolioBalance,
         let portfolioChangePercent = statsProvider.stats.portfolioChangePercent,
         let daysTradingCount = statsProvider.stats.daysTradingCount,
         let averageDailyClosedCount = statsProvider.stats.averageDailyClosedCount,
         let averageDailyClosedProfit = statsProvider.stats.averageDailyClosedProfit,
         let bagsCount = statsProvider.stats.bagsCount,
         let bagsAmount = statsProvider.stats.bagsAmount,
         let oldestBag = statsProvider.stats.biggestBag,
         let activeBots = statsProvider.stats.activeBots,
         let mostTradedAsset = statsProvider.stats.mostTradedAsset,
         let largestDeal = statsProvider.stats.largestDeal,
         let bitcoinTicker = statsProvider.stats.bitcoinTicker,
         let ethereumTicker = statsProvider.stats.ethereumTicker,
         let dogecoinTicker = statsProvider.stats.dogecoinTicker
      {
        print("dbark - yep!")
//        self.currentActiveDealsCount = currentActiveDealsCount
        self.dealsClosedTodayCount = dealsClosedTodayCount
        self.totalClosedDealCount = totalClosedDealCount
        self.dealsClosedNoSafetyOrdersPercent = dealsClosedNoSafetyOrdersPercent
        self.dealsClosedSomeSafetyOrdersPercent = dealsClosedSomeSafetyOrdersPercent
        self.dealsClosedMaxSafetyOrdersPercent = dealsClosedMaxSafetyOrdersPercent
        self.todaysProfit = todaysProfit
        self.totalProfit = totalProfit
        self.averageProfit = averageProfit
        self.averageActiveAge = averageActiveAge
        self.todayAverageCloseAge = todayAverageCloseAge
        self.totalAverageCloseAge = totalAverageCloseAge
        self.fearGreedIndex = fearGreedIndex
        self.portfolioBalance = portfolioBalance
        self.portfolioChangePercent = portfolioChangePercent
        self.daysTradingCount = daysTradingCount
        self.averageDailyClosedCount = averageDailyClosedCount
        self.averageDailyClosedProfit = averageDailyClosedProfit
        self.bagsCount = bagsCount
        self.bagsAmount = bagsAmount
        self.oldestBag = oldestBag
        self.activeBots = activeBots
        self.mostTradedAsset = mostTradedAsset
        self.largestDeal = largestDeal
        self.bitcoinTicker = bitcoinTicker
        self.ethereumTicker = ethereumTicker
        self.dogecoinTicker = dogecoinTicker
      } else {
        print("dbark - nope!")
      }
    } catch {
      print("Error loading stats: \(error)")
    }
  }
}
