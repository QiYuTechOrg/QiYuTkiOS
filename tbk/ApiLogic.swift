import Foundation
import Logging

/// API 接口处理逻辑
class ApiLogic {
    /// 处理错误码
    public static func processErrno(errno: ApiDtAppErrno?) {
        guard let errno = errno else {
            return
        }

        switch errno {
        case 0: return
        case 1: return
        case 2: return
        case 10: return // invalid_user_input = 10
        case 11: return // auth_failed = 11  # 认证失败
        case 21: // token_invalid = 21  # 无效的 token 客户端应该执行退出 重新登录
            do {
                UserLogic.logout()
                return
            }
        case 22: return // ztk_error = 22  # 折淘客错误
        case 23: return // user_not_exists = 23  # 用户不存在
        case 40:  // no_channel_id = 40  # 没有渠道 id 客户端应该 认为 没有绑定淘宝账号 这个时候自动退出
            do {
                AppUserSettings.shared.channelId = ""
                return
            }
        default: return
        }
    }

    /// 更新自己的用户信息
    public static func updateProfile() {
        let logger = Logger(label: "appleLogin")

        logger.info("start update profile")

        let token = AppUserSettings.shared.token

        guard token != "" else {
            logger.error("token is empty: \(token)")
            return
        }

        logger.info("request user profile")
        let form = ApiDtUserTokenForm(token: token)
        ApiUserProfileStub.my_post(args: form, failure_cb: {
            logger.error("request profile error")
        }) { ret in
            logger.debug("profile resp: \(ret.errno as Any)")
            ApiLogic.processErrno(errno: ret.errno)

            guard ret.errno == 0, let data = ret.data else {
                return
            }

            let user = AppUserSettings.shared

            if let nickname = data.ali_name {
                user.tbNickName = nickname
            }
            if let tao_id = data.tao_id {
                user.taoId = tao_id
            }
        }
    }
}
