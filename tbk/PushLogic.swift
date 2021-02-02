import Foundation
import Logging


/// 推送的逻辑
class PushLogic {

    static var logger = Logger(label: "推送")


    /// 注册推送的信息
    ///
    public static func register() {
        let pushDevice = AppGlobalSettings.shared.deviceToken
        if (pushDevice == "") {
            return;
        }

        let _ = AppUserSettings.shared.token
        // 不注册推送 token
    }
}
