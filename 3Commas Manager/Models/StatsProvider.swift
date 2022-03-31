//
//  StatsProvider.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import Foundation

class StatsProvider: ObservableObject {
  
//  static let shared = StatsProvider()
  
  @Published var stats = Stats()
  @Published var currentActiveDealsCount = ""

  func fetchStats(account: String) async throws {
    print("dbark - fetching stats")
    let apiKey = APISettings.fetchAPISettings().apiKey
    let secretKey = APISettings.fetchAPISettings().secretKey
    let urlBase = APISettings.fetchAPISettings().urlBase
    let statsEndpoint = APISettings.fetchAPISettings().statsEndpoint
    let signature = CryptoUtilities.signRequest(input: apiKey, secretKey: secretKey)
    
    let statsURL = URL(string: urlBase + statsEndpoint + "?account=\(account)")!
    print("dbark - stats url: \(statsURL)")
    var urlRequest = URLRequest(url: statsURL)
    urlRequest.setValue(apiKey, forHTTPHeaderField: "apiKey")
    urlRequest.setValue(signature, forHTTPHeaderField: "signature")
    let (data, _) = try await URLSession.shared.data(for: urlRequest)
    
    //@todo check for API errors
    
    do {
      print("dbark - decoding stats")
      let jsonDecoder = JSONDecoder()
      let statsData = try jsonDecoder.decode(StatsData.self, from: data)
      DispatchQueue.main.async {
        print("dbark - updating stats")
        self.stats = statsData.stats
        self.currentActiveDealsCount = self.stats.currentActiveDealsCount
      }
//      return stats
    } catch {
      print("dbark - Error decoding json stats data: \(error)")
    }
    
//    return stats
  }
  
}
