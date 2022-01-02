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
        let apiKey = APISettings.fetchAPISettings().apiKey
        let secretKey = APISettings.fetchAPISettings().secretKey
        let urlBase = APISettings.fetchAPISettings().urlBase
        let dealsEndpoint = APISettings.fetchAPISettings().dealsEndpoint
        let signature = CryptoUtilities.signRequest(input: apiKey, secretKey: secretKey)
        
        let finishedDealsURL = URL(string: urlBase + dealsEndpoint + "?account=\(account)&finished=true&order=desc")!
        var urlRequest = URLRequest(url: finishedDealsURL)
        urlRequest.setValue(apiKey, forHTTPHeaderField: "apiKey")
        urlRequest.setValue(signature, forHTTPHeaderField: "signature")
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
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
