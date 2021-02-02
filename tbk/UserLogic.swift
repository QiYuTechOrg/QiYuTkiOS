import Foundation
import SwiftUI
import Logging

/// 用户状态的处理逻辑
class UserLogic {

    private static var logger = Logger(label: "用户")

    /// 用户退出登陆
    public static func logout() {
        /// 因为有可能影响到 界面相关的 动作
        /// 所以放到 main 里面运行
        DispatchQueue.main.async {
            let user = AppUserSettings.shared

            user.tbNickName = ""

            // main
            user.token = ""

            //
            user.uid = ""
            user.mobile = ""
            user.taoId = ""
            user.channelId = ""
        }
    }

    public static func fetchUserProfile() {
        self.fetchUserProfile(cb: { _ in })
    }

    // 获取用户的信息
    // cb 是回调函数 ok -> 表示是否获取成功
    public static func fetchUserProfile(cb: @escaping (_ ok: Bool) -> Void) {
        let token = AppUserSettings.shared.token

        let form = ApiDtUserTokenForm(token: token)
        ApiUserProfileStub.my_post(args: form, failure_cb: {
            cb(false)
        }) { ret in
            guard ret.errno == 0, let data = ret.data else {
                cb(false)
                return
            }

            let user = AppUserSettings.shared

            if let mobile = data.mobile {
                user.mobile = mobile
            }
            if let taoId = data.tao_id {
                user.taoId = taoId
            }
            if let relation_id = data.relation_id {
                user.channelId = relation_id
            }
        }
    }

    public static func login(code: String, nickname: String, email: String) {
        logger.info("apple login code: \(code) nickname: \(nickname) email: \(email)")
    }

    public static func checkLogin() -> Bool {
        return AppUserSettings.checkLogin()
    }

    public static func checkBindTaoBao() -> Bool {
        if (checkLogin() == false) {
            return false
        }

        let user = AppUserSettings.shared;
        return user.channelId != ""
    }

    /// 检测用户已经登陆并且绑定了淘宝
    ///
    /// - Parameters:
    ///   - show: 是否展示信息
    ///   - msg:  展示的消息内容
    /// - Returns: true 表示已经登陆并且绑定了淘宝
    public static func checkLoginAndBindTaoBao(show: Binding<Bool>, msg: Binding<String>) -> Bool {
        msg.wrappedValue = ""
        defer {
            if (msg.wrappedValue != "") {
                show.wrappedValue = true
            }
        }

        if (!AppUserSettings.checkLogin()) {
            msg.wrappedValue = "请您先登陆"
            return false
        }

        let user = AppUserSettings.shared;
        if (user.channelId == "") {
            msg.wrappedValue = "请先绑定淘宝账号"
            return false
        }

        return true
    }
}
