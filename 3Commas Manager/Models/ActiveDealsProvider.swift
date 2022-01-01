//
//  ActiveDealsProvider.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import Foundation

struct ActiveDealProvider {
    
    static let shared = ActiveDealProvider()
    
    func fetchActiveDeal(account: String) async throws -> [ActiveDeal] {
        let activeDealURL = URL(string: "https://dbarkman.com/api/deals?account=\(account)&finished=true&order=desc")!
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: activeDealURL))
        var activeDealList = [ActiveDeal]()
        
        //@todo check for API errors
        
        do {
            let jsonDecoder = JSONDecoder()
            let activeDeals = try jsonDecoder.decode(ActiveDealData.self, from: data)
            activeDealList = activeDeals.activeDealList
            return activeDealList
        } catch {
            print("Error decoding json data: \(error)")
        }
        
        return activeDealList
    }
    
}
