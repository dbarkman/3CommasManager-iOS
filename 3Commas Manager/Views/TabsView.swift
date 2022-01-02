//
//  TabsView.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView {
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "list.bullet.rectangle")
                }
            ActiveDealsView()
                .tabItem {
                    Label("Active", systemImage: "play.circle")
                }
            FinishedDealsView()
                .tabItem {
                    Label("Finished", systemImage: "stop.circle")
                }
            AssetsView()
                .tabItem {
                    Label("Assets", systemImage: "bitcoinsign.circle")
                }
            BotsView()
                .tabItem {
                    Label("Bots", systemImage: "eyeglasses")
                }
        }
    }
}
