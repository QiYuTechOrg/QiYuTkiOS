import Foundation
import SwiftUI
import Logging

enum MyAliAuthFailed {
    case r1
    case r2
    case r3
    case r4
    case success
}

extension MyAliAuthFailed: CustomStringConvertible {
    public var description: String {
        get {
            switch self {
            case .r1: return "1: 阿里百川初始化失败"
            case .r2: return "2: 阿里百川初始化失败"
            case .r3: return "3: 获取用户信息失败"
            case .r4: return "4: 获取用户信息失败"
            case .success: return "阿里百川授权成功"
            }
        }
    }
}


/// 淘宝授权辅助类
struct TaoBaoAuthLogic {
    let controller: UIViewController

    let logger = Logging.Logger(label: "淘宝")

    /**
     * 淘宝认证 使用 openByUrl
     */
    public func authByUrl(showMsg: Binding<Bool>, tipMsg: Binding<String>) {
        let token = AppUserSettings.shared.token
        let form = ApiDtAuthUrlForm(token: token)
        ApiTaobaoAuthUrlStub.my_post(args: form, failure_cb: {
            tipMsg.wrappedValue = "获取淘宝地址失败"
            showMsg.wrappedValue = true
        }) { model in
            ApiLogic.processErrno(errno: model.errno)

            defer {
                if tipMsg.wrappedValue != "" {
                    showMsg.wrappedValue = true
                }
            }

            guard model.errno == 0, let data = model.data else {
                tipMsg.wrappedValue = "服务器错误 \(model.errmsg as Any)"
                return;
            }

            let url = data.url

            DispatchQueue.main.async {
                let bc = AlibcTradeSDK.sharedInstance()
                let service = bc?.tradeService()
                let identity = "trade" // fixed value

                service?.open(byUrl: url, identity: identity, webView: nil, parentController: self.controller, showParams: nil, taoKeParams: nil, trackParam: nil, tradeProcessSuccessCallback: nil)
            }
        }
    }

    /**
     * 淘宝认证
     * 首先进行淘宝本地的认证，然后在进行 渠道 ID 的认证，
     * 这样可以保证渠道 ID 认证的时候不需要 密码
     * sheet 是否展示 认证的 sheet
     * url 注意: 只有当 URL 成功的时候才允许 打开 sheet 进行认证
     */
    public func auth(showMsg: Binding<Bool>, tipMsg: Binding<String>, sheet: Binding<MeActivitySheet?>, tbUrl: Binding<String>) {
        defer {
            if tipMsg.wrappedValue != "" {
                showMsg.wrappedValue = true
            }
        }

        guard let instance = ALBBSDK.sharedInstance() else {
            logger.critical("获取阿里百川 SDK 失败")
            tipMsg.wrappedValue = MyAliAuthFailed.r1.description
            return
        }

        instance.setH5Only(false)
        instance.auth(self.controller,
            successCallback: {
                defer {
                    if tipMsg.wrappedValue != "" {
                        showMsg.wrappedValue = true
                    }
                }

                self.logger.info("阿里百川授权成功")
                let user = ALBBCompatibleSession.sharedInstance()?.getUser()
                guard let u = user else {
                    self.logger.info("阿里百川用户信息失败")
                    tipMsg.wrappedValue = MyAliAuthFailed.r4.description
                    return
                }

                let settings = AppUserSettings.shared;
                settings.tbNickName = u.nick
                // settings.taoId = u.openId

                // self.authByUrl(showMsg: showMsg, tipMsg: tipMsg)

                self.logger.info("请求服务器绑定淘宝的 url")

                let token = AppUserSettings.shared.token
                let form = ApiDtAuthUrlForm(token: token)
                ApiTaobaoAuthUrlStub.my_post(args: form, failure_cb: {
                    tipMsg.wrappedValue = "获取淘宝地址失败"
                    showMsg.wrappedValue = true
                }) { model in
                    ApiLogic.processErrno(errno: model.errno)

                    defer {
                        if tipMsg.wrappedValue != "" {
                            showMsg.wrappedValue = true
                        }
                    }

                    self.logger.info("服务器返回: \(model)")

                    guard model.errno == 0, let data = model.data else {
                        tipMsg.wrappedValue = "服务器错误 \(model.errmsg as Any)"
                        return;
                    }

                    let url = data.url

                    self.logger.info("open tb auth sheet: \(url)")

                    DispatchQueue.main.async {
                        tbUrl.wrappedValue = url
                        sheet.wrappedValue = MeActivitySheet.tb
                    }
                }
            },
            failureCallback: { error in
                let e = error?.localizedDescription ?? "";
                self.logger.error("阿里百川: 失败 \(e)")
            })
    }
}


// 淘宝打开商品页面
struct TaoBaoBuyLogic {
    let controller: UIViewController

    let logger = Logging.Logger(label: "购买")

    // 测试打开一个商品连接
    // https://baichuan.taobao.com/docs/doc.htm?treeId=129&articleId=118399&docType=1
    public func buyItem(itemId: String) {
        logger.info("buy item: \(itemId)")

        let form = ApiDtGaoYongForm(item_id: itemId, token: AppUserSettings.shared.token)
        ApiZtkGaoYongStub.my_post(args: form, failure_cb: {
            self.logger.error("gao yong convert failed! wtf this is ")
        }) { model in
            self.logger.info("buy item resp: \(model)")
            guard model.errno == 0, let data = model.data else {
                return
            }

            let url = data.coupon_click_url

            // use degrade URL for apple audit
            let showParams = AlibcTradeShowParams()
            showParams.openType = .auto
            showParams.nativeFailMode = .jumpH5
            showParams.isNeedCustomNativeFailMode = true
            showParams.degradeUrl = url

            let bc = AlibcTradeSDK.sharedInstance()
            let service = bc?.tradeService()
            let identity = "trade" // fixed value
            service?.open(byUrl: url, identity: identity, webView: nil, parentController: self.controller, showParams: showParams, taoKeParams: nil, trackParam: nil, tradeProcessSuccessCallback: nil)
        }
    }
}


/// 淘宝分享逻辑
struct TaoBaoShareLogic {

    public static var tkl = ""

    @Binding var tipMsg: String
    @Binding var tipActionSheet: ItemDetailActionSheetEnum?

    @Binding var showShareSheet: Bool

    let logger = Logging.Logger(label: "淘宝分享")

    /// 分享一个 iOS 商品
    ///
    /// 这个用户可以没有绑定渠道 id
    ///
    /// - Parameter itemId:
    public func shareIosItem(itemId: String) {
        assert(UserLogic.checkLogin(), "用户没有登陆")

        let token = AppUserSettings.shared.token
        let form = ApiDtShareItemTklForm(item_id: itemId, token: token)
        ApiShareIosNoRelationTklStub.my_post(args: form, failure_cb: {
            self.tipMsg = "获取分享淘口令失败, 请稍后再试"
            self.tipActionSheet = .tipMsg
        }) { ret in
            self.logger.info("share item resp:\(ret)")
            ApiLogic.processErrno(errno: ret.errno)

            guard ret.errno == 0, let tkl = ret.data else {
                let errmsg = ret.errmsg
                self.tipMsg = "获取淘口令失败: \(errmsg)"
                self.tipActionSheet = .tipMsg
                return
            }

            DispatchQueue.main.async {
                logger.info("淘口令: \(tkl)")
                TaoBaoShareLogic.tkl = tkl
                self.showShareSheet = true
            }
        }
    }

    /// 分享一个商品
    public func shareItem(itemId: String) {
        assert(UserLogic.checkLogin(), "用户没有登陆")
        assert(UserLogic.checkBindTaoBao(), "用户没有绑定淘宝")

        let token = AppUserSettings.shared.token
        let form = ApiDtShareItemTklForm(item_id: itemId, token: token)

        ApiShareIosRelationTklStub.my_post(args: form, failure_cb: {
            self.tipMsg = "获取分享淘口令失败, 请稍后再试"
            self.tipActionSheet = .tipMsg
        }) { ret in
            ApiLogic.processErrno(errno: ret.errno)

            guard ret.errno == 0, let tkl = ret.data else {
                let errmsg = ret.errmsg
                self.tipMsg = "获取淘口令失败: \(errmsg)"
                self.tipActionSheet = .tipMsg
                return
            }

            DispatchQueue.main.async {
                logger.info("淘口令: \(tkl)")
                TaoBaoShareLogic.tkl = tkl
                self.showShareSheet = true
            }
        }
    }
}
