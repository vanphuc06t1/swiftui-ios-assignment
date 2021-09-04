//
//  FeedDetailView.swift
//  ios-assignment
//
//  Created by Phuc Bui  on 9/2/21.
//

import SwiftUI
import WebKit

struct FeedDetailView: View {
    
    @ObservedObject var viewModel : FeedDetailViewModel
    @ObservedObject var webViewModel : WebViewModel
    @ObservedObject var segmentViewModel : SegmentViewModel
    
    var body: some View {
        VStack {
            if segmentViewModel.selection == 0 {//Web
                LoadingView(isShowing: self.$webViewModel.isLoading) {
                    WebView(viewModel: self.webViewModel)
                }
            } else {//Smart
                LoadingView(isShowing: self.$viewModel.isLoading) {
                    ReaderFeedDetailView(viewModel: viewModel)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                ReaderSegmentView(viewModel: segmentViewModel)
            }
        }
        .onAppear {
            self.viewModel.loadFeedContents()
            self.viewModel.loadFeedRelateds()
        }

        
    }
}

struct WebView: UIViewRepresentable {
    
    //MARK: - Properties
    @ObservedObject var viewModel: WebViewModel
    
    private let webView = WKWebView()

    func makeCoordinator() -> Coordinator {
        Coordinator(self.viewModel)
    }
    
    //MARK: - Coordinator
    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel
        
        init(_ viewModel: WebViewModel) {
            self.viewModel = viewModel
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.viewModel.isLoading = false
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            self.viewModel.isLoading = true
        }
    }
    
    //MARK: - UIViewRepresentable
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<WebView>) { }
    
    func makeUIView(context: Context) -> UIView {
        self.webView.navigationDelegate = context.coordinator

        if let url = URL(string: self.viewModel.url) {
            self.webView.load(URLRequest(url: url))
        }

        return self.webView
    }
}

