//
//  StatsView.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import SwiftUI

struct StatsView: View {
    
    var statsProvider: StatsProvider = .shared
    
    @State private var stats = Stats()
    @State private var account = "real"
    @State private var currentActiveDealsCount = ""
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
    @State private var usdtAvailable = ""
    @State private var daysTradingCount = ""
    @State private var averageDailyClosedCount = ""
    @State private var averageDailyClosedProfit = ""
    @State private var bagsCount = ""
    @State private var bagsAmount = ""
    @State private var biggestBag = ""
    @State private var activeBots = ""
    @State private var mostTradedAsset = ""
    @State private var largestDeal = ""
    @State private var bitcoinTicker = ""
    @State private var ethereumTicker = ""
    @State private var dogecoinTicker = ""
    @State private var buildNumber = ""
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    HStack {
                        Text("Current Active Deals")
                        Spacer()
                        Text(currentActiveDealsCount)
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
                        Text("Bags, Less Than -$100")
                        Spacer()
                        Text(bagsCount)
                    }
                    HStack {
                        Text("Bags Total Cost")
                        Spacer()
                        Text("$\(bagsAmount)")
                    }
                    HStack {
                        Text("Biggest Bag")
                        Spacer()
                        Text("$\(biggestBag)")
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
                        Text("USDT Available")
                        Spacer()
                        Text("$\(usdtAvailable)")
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
                Group {
                    HStack {
                        Text("Build Number")
                        Spacer()
                        Text(buildNumber)
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
            stats = try await statsProvider.fetchStats(account: account)
            if let currentActiveDealsCount = stats.currentActiveDealsCount,
               let dealsClosedTodayCount = stats.dealsClosedTodayCount,
               let totalClosedDealCount = stats.totalClosedDealCount,
               let dealsClosedNoSafetyOrdersPercent = stats.dealsClosedNoSafetyOrdersPercent,
               let dealsClosedSomeSafetyOrdersPercent = stats.dealsClosedSomeSafetyOrdersPercent,
               let dealsClosedMaxSafetyOrdersPercent = stats.dealsClosedMaxSafetyOrdersPercent,
               let todaysProfit = stats.todaysProfit,
               let totalProfit = stats.totalProfit,
               let averageProfit = stats.averageProfit,
               let averageActiveAge = stats.averageActiveAge,
               let todayAverageCloseAge = stats.todayAverageCloseAge,
               let totalAverageCloseAge = stats.totalAverageCloseAge,
               let fearGreedIndex = stats.fearGreedIndex,
               let portfolioBalance = stats.portfolioBalance,
               let usdtAvailable = stats.usdtAvailable,
               let daysTradingCount = stats.daysTradingCount,
               let averageDailyClosedCount = stats.averageDailyClosedCount,
               let averageDailyClosedProfit = stats.averageDailyClosedProfit,
               let bagsCount = stats.bagsCount,
               let bagsAmount = stats.bagsAmount,
               let biggestBag = stats.biggestBag,
               let activeBots = stats.activeBots,
               let mostTradedAsset = stats.mostTradedAsset,
               let largestDeal = stats.largestDeal,
               let bitcoinTicker = stats.bitcoinTicker,
               let ethereumTicker = stats.ethereumTicker,
               let dogecoinTicker = stats.dogecoinTicker
            {
                self.currentActiveDealsCount = currentActiveDealsCount
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
                self.usdtAvailable = usdtAvailable
                self.daysTradingCount = daysTradingCount
                self.averageDailyClosedCount = averageDailyClosedCount
                self.averageDailyClosedProfit = averageDailyClosedProfit
                self.bagsCount = bagsCount
                self.bagsAmount = bagsAmount
                self.biggestBag = biggestBag
                self.activeBots = activeBots
                self.mostTradedAsset = mostTradedAsset
                self.largestDeal = largestDeal
                self.bitcoinTicker = bitcoinTicker
                self.ethereumTicker = ethereumTicker
                self.dogecoinTicker = dogecoinTicker
            }
        } catch {
            print("Error loading stats: \(error)")
        }
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            self.buildNumber = buildNumber
        }
    }
}
