import SwiftUI
import Logging

/// 淘宝认证的 sheet
struct TaoBaoAuthSheet: View {
    let url: String

    let logger = Logger(label: "auth")

    private func getRootViewController() -> UIViewController {
        UIApplication.shared.windows.first!.rootViewController!
    }

    var body: some View {
        TaoBaoAuthWebView(url: url, controller: getRootViewController())
            .onDisappear {
                ApiLogic.updateProfile()
            }
    }
}
