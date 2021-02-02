import Foundation
import WebKit

// APP WebView 辅助函数
class AppWebViewUtils {
    // 获取 WK 配置
    private static func getPreference() -> WKPreferences {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")

        return preferences
    }

    /// 优化版的 getConfiguration
    /// 减少重复代码量
    ///
    /// - Parameter coordinator:
    /// - Returns:
    public static func getConfigurationByCoordinator(coordinator: WKScriptMessageHandler) -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()

        configuration.setValue(true, forKey: "allowUniversalAccessFromFileURLs")

        // Here "iOSNative" is our interface name that we pushed to the website that is being loaded
        configuration.userContentController.add(coordinator, name: MyWKMessageName.iOSOpenItem.rawValue)
        configuration.userContentController.add(coordinator, name: MyWKMessageName.iOSUuid.rawValue)
        configuration.userContentController.add(coordinator, name: MyWKMessageName.iOSToken.rawValue)

        //
        configuration.preferences = getPreference()

        // 设置运行环境
        let set_env_script = getSetEnvUserScript()
        configuration.userContentController.addUserScript(set_env_script)

        return configuration
    }

    /// 配置 Web 浏览器
    ///
    /// - Parameters:
    ///   - webView:
    ///   - autoLightDarkMode: 是否支持 自动切换 正常/黑暗 模式
    public static func configWebView(webView: WKWebView, autoDarkMode: Bool = true) {
        if (autoDarkMode) {
            // hide WebView background
            // https://developer.apple.com/forums/thread/121139
            webView.isOpaque = false
            webView.backgroundColor = .clear
        }

        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
    }

    /// 获取设置运行时环境的 代码
    private static func getSetEnvUserScript() -> WKUserScript {
        // 设置特殊变量
        // 在 手机端 使其知道运行在 iOS 设备上
        let source: String

        if in_test_env() {
            source = "let appleIosEnv = 'dev';"
        } else {
            source = "let appleIosEnv = 'prod';"
        }


        return WKUserScript(source: source, injectionTime: .atDocumentStart, forMainFrameOnly: false)
    }
}
