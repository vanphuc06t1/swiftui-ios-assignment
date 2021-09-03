//
//  FeedView.swift
//  ios-assignment
//
//  Created by Phuc Bui  on 8/29/21.
//

import SwiftUI
import Combine

struct FeedView: View {
    
    //MARK: - Properties
    private let feed: FeedNews
    
    //MARK: - Lifecycles
    init(feed: FeedNews) {
        self.feed = feed
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                FeedImageView(url: URL(string: feed.imageURL), width: 70.0, height: 60.0)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(feed.title)
                    .font(.system(size: 16))
                    .foregroundColor(Color.black)
                    .padding(.top, 6)
                Text("\(feed.sourceName)")
                    .font(.system(size: 13))
                    .foregroundColor(Color.gray)
                    .padding(.bottom, 6)
            }
        }
    }
}
