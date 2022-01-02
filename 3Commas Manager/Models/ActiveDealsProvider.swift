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
        let apiKey = APISettings.fetchAPISettings().apiKey
        let secretKey = APISettings.fetchAPISettings().secretKey
        let urlBase = APISettings.fetchAPISettings().urlBase
        let dealsEndpoint = APISettings.fetchAPISettings().dealsEndpoint
        let signature = CryptoUtilities.signRequest(input: apiKey, secretKey: secretKey)
        
        let activeDealsURL = URL(string: urlBase + dealsEndpoint + "?account=\(account)&finished=false&order=desc")!
        var urlRequest = URLRequest(url: activeDealsURL)
        urlRequest.setValue(apiKey, forHTTPHeaderField: "apiKey")
        urlRequest.setValue(signature, forHTTPHeaderField: "signature")
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
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
