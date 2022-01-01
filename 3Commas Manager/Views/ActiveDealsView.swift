//
//  ActiveDealsView.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import SwiftUI

struct ActiveDealsView: View {
    
    var activeDealProvider: ActiveDealProvider = .shared
    
    @State private var activeDeals = [ActiveDeal]()
    
    var body: some View {
        NavigationView {
            List(activeDeals, id: \.id) { activeDeal in
                VStack(alignment: .leading) {
                    HStack {
                        Text("ATOM")
                        Text("Fri, 12/31, 17:39")
                    }
                    HStack {
                        Text("Gen2 Multi - DCA - Large - 2")
                    }
                    HStack {
                        Text("$0 : $24.65 : $24.93 : $25.05")
                    }
                    HStack {
                        Text("$3.33")
                        Text("1.26%")
                        Text("12 of 15")
                        Text("44 mins")
                    }
                }
                .padding()
            }
            .task { //task requires iOS 15
                await loadActiveDeals()
            }
            .navigationTitle("Active Deals")
        }
    }
    
    private func loadActiveDeals() async {
        do {
            activeDeals.removeAll()
            activeDeals = try await activeDealProvider.fetchActiveDeal(account: "real")
        } catch {
            print("Error loading active deals \(error)")
        }
    }
}
