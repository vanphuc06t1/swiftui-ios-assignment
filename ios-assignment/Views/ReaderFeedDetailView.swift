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

//MARK: - FeedNewsContentView
struct FeedNewsContentView: View {
    // MARK: - PROPERTIES
    var item:FeedContentNews
    
    @State var showPopover = false

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
                                    .gesture(
                                        TapGesture()
                                            .onEnded { _ in
                                                self.showPopover = true
                                            }
                                    )
                                    .popover(isPresented: $showPopover) {
                                        PopOverImageView(showPopover: $showPopover, imageURL: item.imageURL)
                                    }
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

//MARK: - PopOverImageView
struct PopOverImageView: View {
    @Binding var showPopover: Bool
    
    var imageURL : String
    
    var body: some View {
        
        VStack {
            HStack (spacing: 5) {
                Spacer()
                Button(action: {
                    self.showPopover = false
                }, label: {
                    Text("Close")
                        .foregroundColor(Color.white)
                }).padding(.top, 10)
                Spacer()
                    .frame(width: 5)
            }
            
            Spacer()
            FeedImageView(url: URL(string: imageURL), width: UIScreen.main.bounds.size.width - 20, height: 200.0)
            Spacer()

        }
        .background(Color.black.opacity(0.5))
    }
}
