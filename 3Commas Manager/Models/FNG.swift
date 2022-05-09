//
//  FNG.swift
//  3Commas Manager
//
//  Created by David Barkman on 3/30/22.
//

import Foundation

struct FNGData: Decodable {
  
  private enum RootCodingKeys: String, CodingKey {
    case data
  }
  
  private(set) var fngs = [FNG]()
  
  init(from decoder: Decoder) throws {
    let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
    var dataContainer = try rootContainer.nestedUnkeyedContainer(forKey: .data)
    while !dataContainer.isAtEnd {
      if let fng = try? dataContainer.decode(FNG.self) {
        fngs.append(fng)
      } else {
        print("dbark - here 3 - nop")
      }
    }
  }
}

struct FNG: Decodable, Hashable, Identifiable {
  var id = ""
  var value = ""
  var classification = ""
  var date = ""
}
