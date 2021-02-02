import Foundation
import WebKit
import Logging


/**
 *  WKWebView 辅助类
 */
class WebViewUtils {
    /**
     * 设置 key -> value 在 WebView 中
     */
    public static func setValue(webView: WKWebView?, key: String, value: String, logger: Logger) {
        guard let wv = webView else {
            return
        }

        let source = "IOSUtils.set_value(\"\(key)\", \"\(value)\");"
        wv.evaluateJavaScript(source)
    }

    /**
     * WebView 设置 UUID 数据给客户端
     */
    public static func setUUidValue(body: Any?, webView: WKWebView?, logger: Logger) {
        logger.info("recv iOSUuid message")
        if let body = body as? [String: String] {
            guard let key = body["key"] else {
                logger.critical("iOSUuid key is missing")
                return
            }
            let uuid = AppUserSettings.shared.uuid
            WebViewUtils.setValue(webView: webView, key: key, value: uuid, logger: logger)
        } else {
            logger.error("body 数据类型错误")
        }
    }

    /**
     * 设置 token 数据给客户端
     */
    public static func setTokenValue(body: Any?, webView: WKWebView?, logger: Logger) {
        logger.info("recv iOSToken message")
        if let body = body as? [String: String] {
            guard let key = body["key"] else {
                return
            }
            let token = AppUserSettings.shared.token
            WebViewUtils.setValue(webView: webView, key: key, value: token, logger: logger)
        } else {
            logger.error("body 数据类型错误")
        }
    }
}
