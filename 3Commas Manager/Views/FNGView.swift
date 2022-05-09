//
//  FNGView.swift
//  3Commas Manager
//
//  Created by David Barkman on 3/30/22.
//

import SwiftUI

struct FNGView<ViewModel: FNGViewModelable>: View {
  
  @StateObject var viewModel: ViewModel
  
  var body: some View {
    List(viewModel.fngs) { fng in
      VStack(alignment: .leading) {
        Text("\(fng.value ): \(fng.classification)")
          .font(.title)
          .fontWeight(.semibold)
          
        Text(fng.date)
      }
    }
    .task {
      do {
        try await viewModel.fetchFNG()
      } catch {
        print("Error: \(error)")
      }
    }
    .navigationTitle("Fear & Greed Index")
  }
}

struct FNGView_Previews: PreviewProvider {
  static var previews: some View {
    FNGView(viewModel: FNGViewModel_Previews())
  }
}
