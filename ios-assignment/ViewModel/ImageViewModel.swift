//
//  ImageViewModel.swift
//  ios-assignment
//
//  Created by Phuc Bui  on 9/2/21.
//

import Foundation
import SwiftUI
import Combine

protocol ImageViewModel : class {
    func loadImage(from url: URL?)
}

extension FeedImageView {
    class ImageViewModelImpl: ImageViewModel, ObservableObject {
        //MARK: - States
        @Published var imageData: Data?
        @Published var isLoading = false

        //MARK: - Properties
        private static let cache = NSCache<NSURL, NSData>()

        private var cancellables = Set<AnyCancellable>()

        //MARK: - Public functions
        func loadImage(from url: URL?) {
            isLoading = true
            guard let url = url else {
                isLoading = false
                return
            }
            if let data = Self.cache.object(forKey: url as NSURL) {
                imageData = data as Data
                isLoading = false
                return
            }
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    if let data = $0 {
                        Self.cache.setObject(data as NSData, forKey: url as NSURL)
                        self?.imageData = data
                    }
                    self?.isLoading = false
                }
                .store(in: &cancellables)
        }
    }
}
