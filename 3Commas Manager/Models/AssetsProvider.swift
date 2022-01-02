//
//  AssetsProvider.swift
//  3Commas Manager
//
//  Created by David Barkman on 1/1/22.
//

import Foundation

struct AssetsProvider {
    
    static let shared = AssetsProvider()
    
    func fetchAssets(account: String) async throws -> [Asset] {
        let apiKey = APISettings.fetchAPISettings().apiKey
        let secretKey = APISettings.fetchAPISettings().secretKey
        let urlBase = APISettings.fetchAPISettings().urlBase
        let assetsEndpoint = APISettings.fetchAPISettings().assetsEndpoint
        let signature = CryptoUtilities.signRequest(input: apiKey, secretKey: secretKey)
        
        let assetsURL = URL(string: urlBase + assetsEndpoint + "?account=\(account)")!
        var urlRequest = URLRequest(url: assetsURL)
        urlRequest.setValue(apiKey, forHTTPHeaderField: "apiKey")
        urlRequest.setValue(signature, forHTTPHeaderField: "signature")
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        var assetsList = [Asset]()
        
        //@todo check for API errors
        
        do {
            let jsonDecoder = JSONDecoder()
            let assets = try jsonDecoder.decode(AssetsData.self, from: data)
            assetsList = assets.assetsList
            return assetsList
        } catch {
            print("Error decoding json data: \(error)")
        }
        
        return assetsList
    }
    
}
