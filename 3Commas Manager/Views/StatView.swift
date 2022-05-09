//
//  StatView.swift
//  3Commas Manager
//
//  Created by David Barkman on 3/30/22.
//

import SwiftUI

struct StatView: View {
  var label: String
  var data: String
  
  var body: some View {
    HStack {
      Text(label)
      Spacer()
      Text(data)
    }
  }
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView(label: "Total Profit", data: "$20.99")
    }
}
