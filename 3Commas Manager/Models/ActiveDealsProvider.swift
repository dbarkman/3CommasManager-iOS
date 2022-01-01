//
//  ActiveDealsProvider.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import Foundation

struct ActiveDealsProvider {
    
    static let shared = ActiveDealsProvider()
    
    func fetchActiveDeals(account: String) async throws -> [ActiveDeal] {
        let activeDealsURL = URL(string: "https://dbarkman.com/api/deals?account=\(account)&finished=false&order=desc")!
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: activeDealsURL))
        var activeDealsList = [ActiveDeal]()
        
        //@todo check for API errors
        
        do {
            let jsonDecoder = JSONDecoder()
            let activeDeals = try jsonDecoder.decode(ActiveDealsData.self, from: data)
            activeDealsList = activeDeals.activeDealsList
            return activeDealsList
        } catch {
            print("Error decoding json data: \(error)")
        }
        
        return activeDealsList
    }
    
}
