//
//  FNGViewModel.swift
//  3Commas Manager
//
//  Created by David Barkman on 3/30/22.
//

import Foundation

protocol FNGViewModelable: ObservableObject {
  var fngs: [FNG] { get }
  func fetchFNG() async throws
}

class FNGViewModel: FNGViewModelable {
  
  @Published var fngs = [FNG]()
  
  func fetchFNG() async throws {
    print("dbark - here 1")
    let urlBase = APISettings.fetchAPISettings().urlBase
    let detailsEndpoint = APISettings.fetchAPISettings().detailsEndpoint
    let detailsURL = URL(string: urlBase + detailsEndpoint + "?stat=fng")!
    print("dbark - url: \(detailsURL)")
    let urlRequest = APIRequest.getAPIRequest(url: detailsURL)
    let (data, _) = try await URLSession.shared.data(for: urlRequest)

    do {
      let jsonDecoder = JSONDecoder()
      let detailsData = try jsonDecoder.decode(FNGData.self, from: data)
      print("dbark - count: \(detailsData.fngs.count)")
      DispatchQueue.main.async {
        self.fngs = detailsData.fngs
      }
    } catch {
      print("Error decoding json stats data: \(error)")
    }
  }
}
