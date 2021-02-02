import Foundation
import WebKit


class MyViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let myBlog = "https://www.baidu.com/"
        let url: URL! = URL(string: myBlog)
        let request = URLRequest(url: url)

        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.webView.frame.size.height))

        webView.load(request)
    }
}
