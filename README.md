# swiftui-ios-assignment

## App Architecture
Apply MVVM architecture pattern. 

### Functionalities Implementation
 1. **List vertically displaying feed news**
	 * FeedsView handle the vertical feed news. Apply cache images loading
 	 * protocol FeedViewModel and class FeedViewModelImpl handle the view model for list view that showing feed news
 	 * FeedView handle item cell for list view that showing each feed with image

 2. **Display feed news detail view**
	 * FeedDetailView handles segment view showing detail of one feed news. Tab WEB and SMART
	 * WebView UIViewRepresentable handle loading webview
 	 * WebViewModel handle the view model for loading webview 

 3. **Feed image view**
	 * FeedImageView handles that showing image poster of one feed news. Apply cache images loading
	 * protocol ImageViewModel and class ImageViewModelImpl for viewmodel loading image and caching

 4. **FeedNews model**
	 * FeedNews declare one item feed news model
	 * FeedContentNews declare one item feed content news model
	 * FeedRelatedNews declare one item feed related news model

 5. **Smart View**
	 * ReaderFeedDetailView is container view that show feed news content items and related news
	 * FeedNewsContentView is one feed news item view
     * FeedRelatedNewsView show related news of each feed new
	 * PopOverImageView is display popover image view in smart view

 6. **Common**
	 * LoadingView and ActivityIndicatorView for loading activity view
	 * ReaderSegmentView is custom segment view

## Video Demo

Youtube: https://youtu.be/j6zZkpVWP1I

https://user-images.githubusercontent.com/4506079/132082373-7a59c8dd-0ccc-4d7f-8899-61af8a69f67b.mov

 
