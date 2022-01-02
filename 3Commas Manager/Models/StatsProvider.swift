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
        let apiKey = APISettings.fetchAPISettings().apiKey
        let secretKey = APISettings.fetchAPISettings().secretKey
        let urlBase = APISettings.fetchAPISettings().urlBase
        let statsEndpoint = APISettings.fetchAPISettings().statsEndpoint
        let signature = CryptoUtilities.signRequest(input: apiKey, secretKey: secretKey)
        
        let statsURL = URL(string: urlBase + statsEndpoint + "?account=\(account)")!
        var urlRequest = URLRequest(url: statsURL)
        urlRequest.setValue(apiKey, forHTTPHeaderField: "apiKey")
        urlRequest.setValue(signature, forHTTPHeaderField: "signature")
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
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
