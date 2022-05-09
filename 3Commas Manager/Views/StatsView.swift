//
//  StatsView.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import SwiftUI

struct StatsView: View {
  
  @StateObject var statsProvider = StatsProvider()
  
  @State private var stats = Stats()
  @State private var account = "real"
  
  var body: some View {
    NavigationView {
      List {
        Group {
          StatView(label: "Current Active Deals", data: statsProvider.stats.currentActiveDealsCount)
          StatView(label: "Deals Closed Today", data: statsProvider.stats.dealsClosedTodayCount)
          StatView(label: "Total Deals Closed", data: statsProvider.stats.totalClosedDealCount)
          StatView(label: "Today's Profit", data: "$\(statsProvider.stats.todaysProfit)")
          StatView(label: "Total Profit", data: "$\(statsProvider.stats.totalProfit)")
          StatView(label: "Days Trading", data: "\(statsProvider.stats.daysTradingCount) days")
          StatView(label: "Average Deals Closed Daily", data: statsProvider.stats.averageDailyClosedCount)
          StatView(label: "Average Deal Profit", data: "$\(statsProvider.stats.averageProfit)")
          StatView(label: "Average Daily Profit", data: "$\(statsProvider.stats.averageDailyClosedProfit)")
          StatView(label: "Average Age Closed Today", data: "\(statsProvider.stats.todayAverageCloseAge) hours")
        }
        Group {
          StatView(label: "Average Active Age", data: "\(statsProvider.stats.averageActiveAge) hours")
          StatView(label: "Average Age All Close", data: "\(statsProvider.stats.totalAverageCloseAge) hours")
          StatView(label: "Deals Closed w/No SOs", data: "\(statsProvider.stats.dealsClosedNoSafetyOrdersPercent)%")
          StatView(label: "Deals Closed w/Some SOs", data: "\(statsProvider.stats.dealsClosedSomeSafetyOrdersPercent)%")
          StatView(label: "Deals Closed w/Max SOs", data: "\(statsProvider.stats.dealsClosedMaxSafetyOrdersPercent)%")
          StatView(label: "Bags, Less Than -$100", data: statsProvider.stats.bagsCount)
          StatView(label: "Bags Total Cost", data: "$\(statsProvider.stats.bagsAmount)")
          StatView(label: "Biggest Bag", data: "$\(statsProvider.stats.biggestBag)")
          StatView(label: "Active Bots", data: statsProvider.stats.activeBots)
          StatView(label: "Most Traded Asset", data: statsProvider.stats.mostTradedAsset)
        }
        Group {
          StatView(label: "Largest Deal", data: statsProvider.stats.largestDeal)
          StatView(label: "Portfolio Balance", data: "$\(statsProvider.stats.portfolioBalance)")
          StatView(label: "Portfolio Change", data: "\(statsProvider.stats.portfolioChangePercent)%")
          StatView(label: "USDT Available", data: "$\(statsProvider.stats.usdtAvailable)")
          NavigationLink(destination: FNGView(viewModel: FNGViewModel()), label: {
            StatView(label: "Fear & Greed Index", data: statsProvider.stats.fearGreedIndex)
          })
          StatView(label: "Bitcoin", data: "$\(statsProvider.stats.bitcoinTicker)0")
          StatView(label: "Ethereum", data: "$\(statsProvider.stats.ethereumTicker)")
          StatView(label: "Dogecoin", data: "$\(statsProvider.stats.dogecoinTicker)")
          StatView(label: "Build Number", data: statsProvider.buildNumber)
        }
      }
      .task {
        await loadStats(account: account)
      }
      .refreshable {
        await loadStats(account: account)
      }
      .navigationTitle(statsProvider.navigationTitle)
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
    } catch {
      print("Error loading stats: \(error)")
    }
  }
}

struct StatsView_Previews: PreviewProvider {
  static var previews: some View {
    StatsView()
  }
}
