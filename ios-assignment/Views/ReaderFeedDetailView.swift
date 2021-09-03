//
//  ReaderFeedDetailView.swift
//  ios-assignment
//
//  Created by Phuc Bui  on 9/4/21.
//

import SwiftUI

struct ReaderFeedDetailView: View {
    
    @ObservedObject var viewModel : FeedDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack (alignment: .center, spacing: 5) {
                ForEach(self.viewModel.feed.contents, id:\.id) { item in
                    FeedNewsContentView(item: item)
                }
            }
        }
    }
}

struct FeedNewsContentView: View {
    // MARK: - PROPERTIES
    var item:FeedContentNews

    // MARK: - CONTENT
    var body: some View {
        VStack {
            ZStack (alignment: .bottom) {
                VStack {
                    if (!item.title.isEmpty) {
                        Spacer()
                        HStack  {
                            Text(item.title)
                                .font(.headline)
                                .frame(alignment: .leading)
                            Spacer()
                        }//title
                        Spacer()
                    }
                    VStack (spacing: 5) {
                        VStack {
                            if (!item.text.isEmpty) {
                                Text(item.text)
                                    .font(.body)
                            }
                        }
                        HStack {
                            if !item.imageURL.isEmpty {
                                FeedImageView(url: URL(string: item.imageURL), width: UIScreen.main.bounds.size.width - 20, height: 200.0)
                            }
                        }//image
                        if (!item.imageDescription.isEmpty) {
                            Text(item.imageDescription)
                                .font(.footnote)//image description
                        }
                    }
                    Spacer()
                    VStack (spacing: 5) {
                        Text(item.content)
                            .font(.body)
                            .padding(.bottom, 5)//content
                    }
                    
                }
                
            }
        }
        .padding(.horizontal, 10)
    }
}
