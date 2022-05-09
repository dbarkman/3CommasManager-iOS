//
//  StatsProvider.swift
//  3Commas Manager
//
//  Created by David Barkman on 12/31/21.
//

import Foundation

class StatsProvider: ObservableObject {
  
  @Published var stats = Stats()
  @Published var currentActiveDealsCount = ""
  @Published var navigationTitle = "Stats"
  @Published var buildNumber = ""
  
  func fetchStats(account: String) async throws {
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
    
    //@todo check for API errors
    
    do {
      let jsonDecoder = JSONDecoder()
      let statsData = try jsonDecoder.decode(StatsData.self, from: data)
      DispatchQueue.main.async {
        self.stats = statsData.stats
        self.buildNumber = self.fetchBuildNumber()
      }
    } catch {
      print("Error decoding json stats data: \(error)")
    }
  }
  
  func fetchBuildNumber() -> String {
    var buildNum = ""
    if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
      buildNum = buildNumber
    }
    return buildNum
  }
  
}
