//
//  ReaderSegmentView.swift
//  ios-assignment
//
//  Created by Phuc Bui  on 9/4/21.
//

import Foundation
import SwiftUI

class SegmentViewModel: ObservableObject {
    @Published var selection = 0
}

struct ReaderSegmentView: View {
    @ObservedObject var viewModel : SegmentViewModel
    private let items: [String] = ["WEB", "SMART"]
    
    var body: some View {
        VStack(alignment: .center) {
            Picker(selection: $viewModel.selection, label: Text("")) {
                ForEach(0..<items.count, id: \.self) { index in
                    Text(self.items[index]).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
        .padding()
    }
}
