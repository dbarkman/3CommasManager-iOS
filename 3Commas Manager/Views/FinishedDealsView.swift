//
//  FinishedDealsView.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import SwiftUI

struct FinishedDealsView: View {

    var finishedDealsProvider: FinishedDealsProvider = .shared
    
    @State private var finishedDeals = [FinishedDeal]()
    @State private var account = "real"

    var body: some View {
        NavigationView {
            List(finishedDeals, id: \.id) { finishedDeal in
                VStack(alignment: .leading) {
                    HStack {
                        Text(finishedDeal.to_currency)
                    }
                    HStack {
                        Text(finishedDeal.closedAtDateTime)
                        Spacer()
                        Text("Age: \(finishedDeal.age)")
                    }
                    HStack {
                        Text("$\(finishedDeal.final_profit)")
                        Spacer()
                        Text("\(finishedDeal.final_profit_percentage)%")
                        Spacer()
                        Text("\(finishedDeal.completed_safety_orders_count) of \(finishedDeal.max_safety_orders)")
                    }
                    HStack {
                        Text(finishedDeal.bot_name)
                    }
                }
            }
            .task {
                await loadFinishedDeals(account: account)
            }
            .refreshable {
                await loadFinishedDeals(account: account)
            }
            .navigationTitle("Finished Deals")
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
            await loadFinishedDeals(account: "paper")
        } else if account == "paper" {
            account = "real"
            await loadFinishedDeals(account: "real")
        }
    }

    private func loadFinishedDeals(account: String) async {
        do {
            finishedDeals.removeAll()
            finishedDeals = try await finishedDealsProvider.fetchFinishedDeals(account: account)
        } catch {
            print("Error loading finished deals \(error)")
        }
    }
}
