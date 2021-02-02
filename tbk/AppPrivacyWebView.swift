import Foundation
import SwiftUI
import WebKit
import UIKit
import Combine
import Logging


// 加载 URL 的 WebView
struct AppUrlWebView: UIViewRepresentable {
    let logger = Logging.Logger(label: "URLWebView")

    let url: URL           // 访问的 URL
    let autoDarkMode: Bool // 自动开启黑暗模式

    init(url: URL) {
        self.init(url: url, autoDarkMode: true)
    }

    init(url: URL, autoDarkMode: Bool) {
        self.url = url
        self.autoDarkMode = autoDarkMode
    }

    func makeCoordinator() -> GenericWebViewCoordinator {
        GenericWebViewCoordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let coordinator = context.coordinator
        let configuration = AppWebViewUtils.getConfigurationByCoordinator(coordinator: coordinator)
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        coordinator.myWebView = webView
        webView.navigationDelegate = coordinator
        AppWebViewUtils.configWebView(webView: webView, autoDarkMode: self.autoDarkMode)

        // 加载网页
        webView.load(URLRequest(url: self.url))

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        context.coordinator.myWebView = webView
    }
}

