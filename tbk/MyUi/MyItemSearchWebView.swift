import Foundation
import SwiftUI
import WebKit
import UIKit
import Combine
import Logging


class MySearchViewModel: ObservableObject {
    @Published var openItem: Bool = false

    static public var shared = MySearchViewModel()
}

/// 商品详情的 WebView
struct MyItemSearchWebView: UIViewRepresentable {
    // 查询的内容
    let q: String

    @ObservedObject var viewModel: MySearchViewModel

    func makeUIView(context: Context) -> WKWebView {
        let coordinator = context.coordinator
        let configuration = AppWebViewUtils.getConfigurationByCoordinator(coordinator: coordinator)

        let script = WKUserScript(source: "SearchDetailScript.load_data_bu_query(\"\(self.q)\")", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
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
        let url = Bundle.main.url(forResource: "html/search_detail", withExtension: "html", subdirectory: "html")
        return url
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: MyItemSearchWebView

        weak var myWebView: WKWebView?

        init(_ uiWebView: MyItemSearchWebView) {
            self.parent = uiWebView
        }
    }
}

extension MyItemSearchWebView.Coordinator: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let logger = Logging.Logger(label: "wk_search")

        if message.name == MyWKMessageName.iOSOpenItem.rawValue {
            logger.info("recv iOSOpenItem message")
            if let body = message.body as? [String: String] {
                if let item_id = body["item_id"] {
                    ItemDetailContentView.g_item_id = item_id
                    self.parent.viewModel.openItem = true
                }
            }
        } else if message.name == MyWKMessageName.iOSUuid.rawValue {
            WebViewUtils.setUUidValue(body: message.body, webView: self.myWebView, logger: logger)
        } else if message.name == MyWKMessageName.iOSToken.rawValue {
            WebViewUtils.setTokenValue(body: message.body, webView: self.myWebView, logger: logger)
        } else {
            logger.critical("WKWebView recv unknown msg: \(message.name)")
        }
    }
}
