//
//  FeedImageView.swift
//  ios-assignment
//
//  Created by Phuc Bui  on 9/2/21.
//

import Foundation
import SwiftUI

struct FeedImageView: View {
    //State
    @StateObject private var viewModel = ImageViewModelImpl()

    //Properties
    let url: URL?
    let width: CGFloat
    let height: CGFloat

    //body
    var body: some View {
        Group {
            if let data = viewModel.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .cornerRadius(4)
                    .frame(width: width, height: height)
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "photo")
                    .frame(width: width, height: height)
            }
        }
        .onAppear {
            viewModel.loadImage(from: url)
        }
    }
}
