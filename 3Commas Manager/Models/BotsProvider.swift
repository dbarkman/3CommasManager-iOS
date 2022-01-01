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
        let botsURL = URL(string: "https://dbarkman.com/api/botStats?botType=\(botType)")!
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: botsURL))
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
