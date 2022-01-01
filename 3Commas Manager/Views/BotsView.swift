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
    @State private var botType = "Multi"
    
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
                await loadBots(botType: botType)
            }
            .refreshable {
                await loadBots(botType: botType)
            }
            .navigationTitle("Bots, beep boop")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(botType.capitalized) {
                        Task {
                            await loadOtherType()
                        }
                    }
                }
            }
        }
    }
    
    private func loadOtherType() async {
        if botType == "Multi" {
            botType = "Single"
            await loadBots(botType: "Single")
        } else if botType == "Single" {
            botType = "Multi"
            await loadBots(botType: "Multi")
        }
    }

    private func loadBots(botType: String) async {
        do {
            bots.removeAll()
            bots = try await botsProvider.fetchBots(botType: botType)
        } catch {
            print("Error loading bots \(error)")
        }
    }
}
