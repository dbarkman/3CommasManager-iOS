//
//  APISettings.swift
//  3Commas Manager
//
//  Created by David Barkman on 1/1/22.
//

import Foundation

struct APISettings {
    static func fetchAPISettings() -> API {
        var apiSettings = API()
        if  let path = Bundle.main.path(forResource: "api", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path)
        {
            do {
                let api = try PropertyListDecoder().decode(API.self, from: xml)
                apiSettings = api
            } catch {
                print("API settings decoding problem: \(error)")
            }
        }
        return apiSettings
    }

}
