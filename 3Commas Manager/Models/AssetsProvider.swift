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
        let assetsURL = URL(string: "https://dbarkman.com/api/assets?account=\(account)")!
        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: assetsURL))
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
