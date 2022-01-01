//
//  FinishedDealsProvider.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import Foundation

struct FinishedDealsProvider {
    
    static let shared = FinishedDealsProvider()
    
    func fetchFinishedDeals(account: String) async throws -> [FinishedDeal] {
        let finishedDealsURL = URL(string: "https://dbarkman.com/api/deals?account=\(account)&finished=true&order=desc")!
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: finishedDealsURL))
        var finishedDealsList = [FinishedDeal]()
        
        //@todo check for API errors
        
        do {
            let jsonDecoder = JSONDecoder()
            let finishedDeals = try jsonDecoder.decode(FinishedDealsData.self, from: data)
            finishedDealsList = finishedDeals.finishedDealsList
            return finishedDealsList
        } catch {
            print("Error decoding json data: \(error)")
        }
        
        return finishedDealsList
    }
    
}
