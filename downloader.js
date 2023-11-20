// This Javascript code needs to be execute in a browser console
// It will open all URLs in new browser tabs

// 1. Declare the list of URLs
// var urlList = [ ... };

// 2. Paste the following function to open URLs in new browser tabs
function openUrlsInNewWindows(urlList) {
  urlList.forEach(function (urlObj) {
    for (var key in urlObj) {
      var url = urlObj[key];
      // Open a new tab
      var newWindow = window.open("", "_blank");
      // Navigate the new tab to the specified URL
      newWindow.location.href = url;
      // You can access cookies and perform other actions on the new tab if needed
      // Example: newWindow.document.cookie = "your_cookie=your_value";
    }
  });
}

// 3. Call the function to open URLs
// openUrlsInNewWindows(urlList);
