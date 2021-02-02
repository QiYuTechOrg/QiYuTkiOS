import Foundation
import SwiftUI
import WebKit
import UIKit
import Combine
import Logging

/// 商品详情的 WebView
struct MyItemDetailWebView: UIViewRepresentable {

    let item_id: String

    func makeUIView(context: Context) -> WKWebView {
        let coordinator = context.coordinator
        let configuration = AppWebViewUtils.getConfigurationByCoordinator(coordinator: coordinator)

        let script = WKUserScript(source: "item_detail_init(\(self.item_id))", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        configuration.userContentController.addUserScript(script)

        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
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
        let url = Bundle.main.url(forResource: "html/item_detail", withExtension: "html", subdirectory: "html")
        return url
    }

    func makeCoordinator() -> GenericWebViewCoordinator {
        GenericWebViewCoordinator()
    }
}

