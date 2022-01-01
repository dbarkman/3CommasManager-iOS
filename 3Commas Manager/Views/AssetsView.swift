//
//  AssetsView.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import SwiftUI

struct AssetsView: View {

    var assetsProvider: AssetsProvider = .shared
    
    @State private var assets = [Asset]()
    @State private var account = "real"
    
    var body: some View {
        NavigationView {
            List(assets, id: \.id) { asset in
                VStack(alignment: .leading) {
                    HStack {
                        Text(asset.symbol)
                        Spacer()
                        Text("$\(asset.profit)")
                        Spacer()
                        Text(asset.deals)
                        Spacer()
                        Text("\(asset.averageProfit)%")
                    }
                }
            }
            .task {
                await loadAssets(account: account)
            }
            .refreshable {
                await loadAssets(account: account)
            }
            .navigationTitle("Top Assets")
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
            await loadAssets(account: "paper")
        } else if account == "paper" {
            account = "real"
            await loadAssets(account: "real")
        }
    }

    private func loadAssets(account: String) async {
        do {
            assets.removeAll()
            assets = try await assetsProvider.fetchAssets(account: account)
        } catch {
            print("Error loading assets \(error)")
        }
    }
}
