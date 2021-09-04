//
//  FeedDetailViewModel.swift
//  ios-assignment
//
//  Created by Phuc Bui  on 9/3/21.
//

import Foundation
import Combine

class FeedDetailViewModel: ObservableObject {
    
    @Published var feedContents: [FeedContentNews] = []
    @Published var feedRelateds: [FeedRelatedNews] = []
    
    @Published var isLoading = false

    //MARK: - Properties
    private let urlStringContents = "https://jsonkeeper.com/b/QXQK"
    private let urlStringRelateds = "https://jsonkeeper.com/b/8XQM"
    private var cancellables = Set<AnyCancellable>()
    
    let feed: FeedNews
    
    init (feed: FeedNews) {
        self.feed = feed
    }
    
    //MARK: - Public functions
    func loadFeedContents() {
        
        isLoading = true
        guard let url = URL(string: urlStringContents) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [[String: [FeedContentNews]]].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] (completion) in
                guard let self = self else {
                    return
                }
                
                switch completion {
                case .failure(let error):
                    print("Error get feed content news:")
                    print(error)
                case .finished:
                    print("DONE - get feed content news")
                }
                self.isLoading = false
                
            }, receiveValue: {[weak self] (contents) in
                guard let self = self else {
                    return
                }
                DispatchQueue.main.async {
                    let dictContent = contents.filter({ (dict) -> Bool in
                        let key = dict.keys.first ?? ""
                        return key == "\(self.feed.idContents)"
                    })
                    self.feedContents = dictContent.first?.values.first ?? []
                }
                self.isLoading = false
            })
            .store(in: &self.cancellables)
        
    }
    
    func loadFeedRelateds() {
        
        guard let url = URL(string: urlStringRelateds) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [[String: [FeedRelatedNews]]].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure(let error):
                    print("Error get feed related news:")
                    print(error)
                case .finished:
                    print("DONE - get feed related news")
                }
                
            }, receiveValue: {[weak self] (contents) in
                guard let self = self else {
                    return
                }
                DispatchQueue.main.async {
                    let dictContent = contents.filter({ (dict) -> Bool in
                        let key = dict.keys.first ?? ""
                        return key == "\(self.feed.idRelateds)"
                    })
                    self.feedRelateds = dictContent.first?.values.first ?? []
                }
            })
            .store(in: &self.cancellables)
        
    }
}

class WebViewModel: ObservableObject {
    @Published var url: String
    @Published var isLoading: Bool = true
    
    init (url: String) {
        self.url = url
    }
}
