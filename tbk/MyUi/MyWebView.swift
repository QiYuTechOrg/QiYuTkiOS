import Foundation
import SwiftUI
import WebKit
import UIKit
import Combine
import Logging


/// 加载数据的类型
enum HtmlLoadType {
    case taoHaoWu
    case juHuaSuan
    case nineNine
    case bangDanTuiJian
    case tMallChaoShi

    // 猜你喜欢
    case guessYouLike
}

class MyViewModel: ObservableObject {

    @Published var openItem: Bool = false

    public static var home_shared = MyViewModel()
    public static var shop_list_shared = MyViewModel()
}


/// copy from https://medium.com/@mdyamin/swiftui-mastering-webview-5790e686833e
///
/// 我的 WebView
struct MyWebView: UIViewRepresentable {

    // ViewModel object
    @ObservedObject var viewModel: MyViewModel

    @Binding var homeSheet: HomeSheetEnum?

    let htmlType: HtmlLoadType

    var logger = Logging.Logger(label: "WV234")

    static private var _myWebViewCache: Dictionary<HtmlLoadType, WKWebView> = [:]

    // Make a coordinator to co-ordinate with WKWebView's default delegate functions
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let wv = MyWebView._myWebViewCache[self.htmlType]
        if let wv2 = wv {
            wv2.navigationDelegate = context.coordinator

            wv2.configuration.userContentController.removeScriptMessageHandler(forName: MyWKMessageName.iOSOpenItem.rawValue)
            wv2.configuration.userContentController.removeScriptMessageHandler(forName: MyWKMessageName.iOSUuid.rawValue)
            wv2.configuration.userContentController.removeScriptMessageHandler(forName: MyWKMessageName.iOSToken.rawValue)

            let coordinator = self.makeCoordinator()
            wv2.configuration.userContentController.add(coordinator, name: MyWKMessageName.iOSOpenItem.rawValue)
            wv2.configuration.userContentController.add(coordinator, name: MyWKMessageName.iOSUuid.rawValue)
            wv2.configuration.userContentController.add(coordinator, name: MyWKMessageName.iOSToken.rawValue)

            return wv2
        }

        let coordinator = context.coordinator
        let configuration = AppWebViewUtils.getConfigurationByCoordinator(coordinator: coordinator)
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        coordinator.myWebView = webView
        webView.navigationDelegate = coordinator
        AppWebViewUtils.configWebView(webView: webView)
        MyWebView._myWebViewCache[self.htmlType] = webView

        /// load url for the first time
        let url = self.getLoadUrl()
        guard let u = url else {
            self.logger.critical("not load url \(self.htmlType)")
            return webView
        }
        webView.loadFileURL(u, allowingReadAccessTo: u.deletingLastPathComponent())
        /// load url for the first time end
        //////////////////////////////////////////////////

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        // if let url = URL(string: "https://www.baidu.com") {
        //     webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        //     webView.load(URLRequest(url: url))
        // }
        context.coordinator.myWebView = webView
    }

    // 获取加载的 网页 URL
    func getLoadUrl() -> URL? {
        nil
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: MyWebView

        weak var myWebView: WKWebView?

        init(_ uiWebView: MyWebView) {
            self.parent = uiWebView
        }
    }
}


extension MyWebView.Coordinator: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let logger = Logging.Logger(label: "wx_wv")

        if message.name == MyWKMessageName.iOSOpenItem.rawValue {
            logger.info("recv iOSOpenItem message")
            if let body = message.body as? [String: String] {
                if let item_id = body["item_id"] {
                    self.parent.homeSheet = .itemDetail

                    ItemDetailContentView.g_item_id = item_id

                    self.parent.viewModel.openItem = true
                }
            }
        } else if message.name == MyWKMessageName.iOSUuid.rawValue {
            WebViewUtils.setUUidValue(body: message.body, webView: self.myWebView, logger: logger)
        } else if message.name == MyWKMessageName.iOSToken.rawValue {
            WebViewUtils.setTokenValue(body: message.body, webView: self.myWebView, logger: logger)
        } else {
            logger.critical("recv unknown msg: \(message.name)")
        }
    }
}

/**
 * 通用的 WebView Coordinator
 */
class GenericWebViewCoordinator: NSObject, WKNavigationDelegate {
    weak var myWebView: WKWebView?
}


extension GenericWebViewCoordinator: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let logger = Logging.Logger(label: "wx_234234")

        if message.name == MyWKMessageName.iOSUuid.rawValue {
            WebViewUtils.setUUidValue(body: message.body, webView: self.myWebView, logger: logger)
        } else if message.name == MyWKMessageName.iOSToken.rawValue {
            WebViewUtils.setTokenValue(body: message.body, webView: self.myWebView, logger: logger)
        } else {
            logger.critical("recv unknown msg: \(message.name)")
        }
    }
}
