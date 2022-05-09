//
//  FNGViewModel_Previews.swift
//  3Commas Manager
//
//  Created by David Barkman on 3/30/22.
//

import Foundation

class FNGViewModel_Previews: FNGViewModelable {

  @Published var fngs = [FNG]()

  func fetchFNG() async throws {
    let fngs = [
      FNG(id: "1", value: "52", classification: "Neutral", date: "Thu, 03/31/22"),
      FNG(id: "2", value: "55", classification: "Greed", date: "Wed, 03/30/22"),
      FNG(id: "3", value: "56", classification: "Greed", date: "Tue, 03/29/22"),
      FNG(id: "4", value: "60", classification: "Greed", date: "Mon, 03/28/22"),
      FNG(id: "5", value: "49", classification: "Neutral", date: "Sun, 03/27/22")
    ]

    DispatchQueue.main.async {
      self.fngs = fngs
    }
  }
}

