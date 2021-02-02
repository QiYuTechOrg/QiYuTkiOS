import Foundation
import SwiftUI
import WebKit
import UIKit
import Combine
import Logging


/// copy from https://medium.com/@mdyamin/swiftui-mastering-webview-5790e686833e
///
/// 我的消息 WebView
struct MyMsgWebView: UIViewRepresentable {
    let msgType: MsgType
    var logger = Logging.Logger(label: "msg_user")

    // Make a coordinator to co-ordinate with WKWebView's default delegate functions
    func makeCoordinator() -> GenericWebViewCoordinator {
        GenericWebViewCoordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let coordinator = context.coordinator;
        let configuration = AppWebViewUtils.getConfigurationByCoordinator(coordinator: coordinator)
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        // wtf web view is nil ?
        coordinator.myWebView = webView
        webView.navigationDelegate = coordinator
        AppWebViewUtils.configWebView(webView: webView)

        /// load url for the first time
        let url = self.getLoadUrl()
        guard let u = url else {
            return webView
        }
        webView.loadFileURL(u, allowingReadAccessTo: u.deletingLastPathComponent())
        /// load url for the first time end
        //////////////////////////////////////////////////

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        context.coordinator.myWebView = webView
    }

    // 获取加载的 网页 URL
    func getLoadUrl() -> URL? {
        let url: URL?
        switch (self.msgType) {
        case .system:
            url = Bundle.main.url(forResource: "html/msg/sys", withExtension: "html", subdirectory: "html")
        case .user:
            url = Bundle.main.url(forResource: "html/msg/user", withExtension: "html", subdirectory: "html")
        }
        self.logger.info("get url: \(url as Any)")
        return url
    }
}

