import Foundation
import SwiftUI
import WebKit
import UIKit
import Combine
import Logging


/// 淘宝认证 WebView
struct TaoBaoAuthWebView: UIViewRepresentable {
    let url: String

    let controller: UIViewController

    var logger = Logging.Logger(label: "wv_tb")

    func makeCoordinator() -> GenericWebViewCoordinator {
        GenericWebViewCoordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let coordinator = context.coordinator
        let configuration = AppWebViewUtils.getConfigurationByCoordinator(coordinator: coordinator)
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        AppWebViewUtils.configWebView(webView: webView)

        coordinator.myWebView = webView

        let bc = AlibcTradeSDK.sharedInstance()
        let service = bc?.tradeService()
        let identity = "trade" // fixed value
        service?.open(byUrl: self.url, identity: identity, webView: webView, parentController: self.controller, showParams: nil, taoKeParams: nil, trackParam: nil, tradeProcessSuccessCallback: nil)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        context.coordinator.myWebView = webView
    }
}


