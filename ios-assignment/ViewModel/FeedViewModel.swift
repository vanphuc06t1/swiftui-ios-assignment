//
//  FeedViewModel.swift
//  ios-assignment
//
//  Created by Phuc Bui  on 8/29/21.
//
import Combine
import SwiftUI
import Foundation

protocol FeedViewModel : class {
    func loadFeedNews()
}

// MARK: - ViewModel
extension FeedsView {
    class FeedViewModelImpl: FeedViewModel, ObservableObject {
        
        //MARK: - States
        @Published var feeds: [FeedNews] = []
        @Published var isLoading = false

        //MARK: - Properties
        private let urlString = "https://jsonkeeper.com/b/DOJ7"
        private var cancellables = Set<AnyCancellable>()
        
        //MARK: - Lifecycles
        init() {
            
        }
        
        //MARK: - Public functions
        func loadFeedNews() {

            isLoading = true
            guard let url = URL(string: urlString) else {
                isLoading = false
                return
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: [FeedNews].self, decoder: JSONDecoder())
                .replaceError(with: [])
                .eraseToAnyPublisher()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {[weak self] (completion) in
                    guard let self = self else {
                        return
                    }
                    
                    switch completion {
                    case .failure(let error):
                        print("Error get feed news:")
                        print(error)
                    case .finished:
                        print("DONE - get feed news")
                    }
                    self.isLoading = false
                    
                }, receiveValue: {[weak self] (feeds) in
                    guard let self = self else {
                        return
                    }
                    DispatchQueue.main.async {
                        self.feeds = feeds
                    }
                    self.isLoading = false
                })
                .store(in: &cancellables)
        
        }
        
    }
}
