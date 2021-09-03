//
//  FeedDetailViewModel.swift
//  ios-assignment
//
//  Created by Phuc Bui  on 9/3/21.
//

import Foundation

class WebViewModel: ObservableObject {
    @Published var url: String
    @Published var isLoading: Bool = true
    
    init (url: String) {
        self.url = url
    }
}
