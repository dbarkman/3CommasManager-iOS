//
//  BotsProvider.swift
//  3Commas Manager
//
//  Created by David Barkman on 1/1/22.
//

import Foundation

struct BotsProvider {
    
    static let shared = BotsProvider()

    func fetchBots(botType: String) async throws -> [Bot] {
        let apiKey = APISettings.fetchAPISettings().apiKey
        let secretKey = APISettings.fetchAPISettings().secretKey
        let urlBase = APISettings.fetchAPISettings().urlBase
        let botsEndpoint = APISettings.fetchAPISettings().botsEndpoint
        let signature = CryptoUtilities.signRequest(input: apiKey, secretKey: secretKey)
        
        let botsURL = URL(string: urlBase + botsEndpoint + "?botType=\(botType)")!
        var urlRequest = URLRequest(url: botsURL)
        urlRequest.setValue(apiKey, forHTTPHeaderField: "apiKey")
        urlRequest.setValue(signature, forHTTPHeaderField: "signature")
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        var botsList = [Bot]()
        
        //@todo check for API errors
        
        do {
            let jsonDecoder = JSONDecoder()
            let bots = try jsonDecoder.decode(BotsData.self, from: data)
            botsList = bots.botsList
            return botsList
        } catch {
            print("Error decoding json data: \(error)")
        }
        
        return botsList
    }
    
}
