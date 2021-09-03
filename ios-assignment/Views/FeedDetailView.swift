//
//  FeedDetailView.swift
//  ios-assignment
//
//  Created by Phuc Bui  on 9/2/21.
//

import SwiftUI
import WebKit

struct FeedDetailView: View {
  
    @ObservedObject var model : WebViewModel
    
    var body: some View {
        LoadingView(isShowing: self.$model.isLoading) {
            WebView(viewModel: self.model)
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

