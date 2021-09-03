//
//  FeedsView.swift
//  ios-assignment
//
//  Created by Phuc Bui  on 8/29/21.
//

import SwiftUI

struct FeedsView: View {

    @ObservedObject var viewModel = FeedViewModelImpl()
    
    private let viewTitle : String = "NewsReader"
    
    var body: some View {
        NavigationView {
            
            HStack(alignment: .top, spacing: 0) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List(viewModel.feeds) { feed in
                        NavigationLink(destination:
                                        FeedDetailView(viewModel:FeedDetailViewModel(feed: feed),
                                                       webViewModel: WebViewModel(url: feed.newsURL),
                                                       segmentViewModel: SegmentViewModel()
                                        )
                        ) {
                            FeedView(feed: feed)
                        }
                    }
                }
            }
            .navigationBarTitle(viewTitle)
            .onAppear {
                self.viewModel.loadFeedNews()
            }

        }
    }
}


