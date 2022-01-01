//
//  ActiveDealsView.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import SwiftUI

struct ActiveDealsView: View {
    
    var activeDealsProvider: ActiveDealsProvider = .shared
    
    @State private var activeDeals = [ActiveDeal]()
    @State private var account = "real"

    var body: some View {
        NavigationView {
            List(activeDeals, id: \.id) { activeDeal in
                VStack(alignment: .leading) {
                    HStack {
                        Text(activeDeal.to_currency)
                    }
                    HStack {
                        Text(activeDeal.createdAtDateTime)
                        Spacer()
                        Text("Age: \(activeDeal.age)")
                    }
                    HStack {
                        Text("$\(activeDeal.actual_profit)")
                        Spacer()
                        Text("\(activeDeal.actual_profit_percentage)%")
                        Spacer()
                        Text("\(activeDeal.completed_safety_orders_count) of \(activeDeal.max_safety_orders)")
                    }
                    HStack {
                        Text("$\(activeDeal.bought_average_price) : $\(activeDeal.current_price) : $\(activeDeal.take_profit_price)")
                    }
                    HStack {
                        Text(activeDeal.bot_name)
                    }
                }
            }
            .task {
                await loadActiveDeals(account: account)
            }
            .refreshable {
                await loadActiveDeals(account: account)
            }
            .navigationTitle("Active Deals")
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
            await loadActiveDeals(account: "paper")
        } else if account == "paper" {
            account = "real"
            await loadActiveDeals(account: "real")
        }
    }

    private func loadActiveDeals(account: String) async {
        do {
            activeDeals.removeAll()
            activeDeals = try await activeDealsProvider.fetchActiveDeals(account: account)
        } catch {
            print("Error loading active deals \(error)")
        }
    }
}
