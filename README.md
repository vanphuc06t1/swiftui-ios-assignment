# swiftui-ios-assignment

## App Architecture
Apply MVVM architecture pattern. 

### Functionalities Implementation
 1. **List vertically displaying feed news**
	 * FeedsView handle the vertical feed news. Apply cache images loading
 	 * protocol FeedViewModel and class FeedViewModelImpl handle the view model for list view that showing feed news
 	 * FeedView handle item cell for list view that showing each feed with image

 2. **Display feed news detail view**
	 * FeedDetailView handles showing detail of one feed news. Showing with webview
	 * WebView UIViewRepresentable handle loading webview
 	 * WebViewModel handle the view model for loading webview 

 3. **Feed image view**
	 * FeedImageView handles that showing image poster of one feed news. Apply cache images loading
	 * protocol ImageViewModel and class ImageViewModelImpl for viewmodel loading image and caching

 4. **FeedNews model**
	 * FeedNews declare one feed new item model

 5. **Common**
	 * LoadingView and ActivityIndicatorView for loading activity view

### Video Demo

https://user-images.githubusercontent.com/4506079/131960208-c7ec5656-e09c-450f-82da-c63ec99e6ea4.mov


 
