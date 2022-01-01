//
//  StatsProvider.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import Foundation

struct StatsProvider {
    
    static let shared = StatsProvider()
    
    func fetchStats(account: String) async throws -> Stats {
        let statsURL = URL(string: "https://dbarkman.com/api/stats?account=\(account)")!
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: statsURL))
        var stats = Stats()
        
        //@todo check for API errors
        
        do {
            let jsonDecoder = JSONDecoder()
            let statsData = try jsonDecoder.decode(StatsData.self, from: data)
            stats = statsData.stats
            return stats
        } catch {
            print("Error decoding json stats data: \(error)")
        }
        
        return stats
    }
    
}
