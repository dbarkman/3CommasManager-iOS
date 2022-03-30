//
//  BotsView.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import SwiftUI

struct BotsView: View {

    var botsProvider: BotsProvider = .shared
    
    @State private var bots = [Bot]()
    @State private var account = "real"
    
    var body: some View {
        NavigationView {
            List(bots, id: \.id) { bot in
                VStack(alignment: .leading) {
                    HStack {
                        Text(bot.bot)
                    }
                    HStack {
                        Text(bot.account)
                        Spacer()
                        Text("$\(bot.totalProfit)")
                        Spacer()
                        Text("\(bot.averageProfit)%")
                    }
                }
            }
            .task {
                await loadBots(account: account)
            }
            .refreshable {
                await loadBots(account: account)
            }
            .navigationTitle("Bots, beep boop")
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
            await loadBots(account: "paper")
        } else if account == "paper" {
            account = "real"
            await loadBots(account: "real")
        }
    }

    private func loadBots(account: String) async {
        do {
            bots.removeAll()
            bots = try await botsProvider.fetchBots(account: account)
        } catch {
            print("Error loading bots \(error)")
        }
    }
}
