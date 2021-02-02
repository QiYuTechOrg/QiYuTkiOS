import Foundation
import Combine

import Logging


/// APP 系统的配置
class AppGlobalSettings: ObservableObject {
    static let shared = AppGlobalSettings()

    @Published var deviceToken: String {
        didSet {
            UserDefaults.standard.set(deviceToken, forKey: AppKeys.DeviceToken.rawValue)
        }
    }

    init() {
        deviceToken = UserDefaults.standard.object(forKey: AppKeys.DeviceToken.rawValue) as? String ?? ""
    }
}

/// APP 全局的用户配置
class AppUserSettings: ObservableObject {
    // 我们使用全局的
    // doc: https://cocoacasts.com/what-is-a-singleton-and-how-to-create-one-in-swift
    static let shared = AppUserSettings()

    static let logger = Logging.Logger(label: "用户设置")

    @Published var uuid: String {
        didSet {
            AppUserSettings.logger.info("update uuid: \(uuid)")
            UserDefaults.standard.set(uuid, forKey: AppUserKeys.UUID.rawValue)
        }
    }

    @Published var uid: String {
        didSet {
            AppUserSettings.logger.info("update uid: \(uid)")
            UserDefaults.standard.set(uid, forKey: AppUserKeys.UID.rawValue)
        }
    }

    @Published var mobile: String {
        didSet {
            AppUserSettings.logger.info("update mobile: \(mobile)")
            UserDefaults.standard.set(mobile, forKey: AppUserKeys.MOBILE.rawValue)
        }
    }

    // 用户的 token 空 string 表示没有登陆
    @Published var token: String {
        didSet {
            AppUserSettings.logger.info("update token")
            UserDefaults.standard.set(token, forKey: AppUserKeys.TOKEN.rawValue)
        }
    }

    @Published var itemSearchHistory: [String] {
        didSet {
            let en = JSONEncoder()
            let j = try! en.encode(itemSearchHistory)
            let s = String(data: j, encoding: .utf8)

            if let v = s {
                UserDefaults.standard.set(v, forKey: AppUserKeys.ItemSearchHistory.rawValue)
            }
        }
    }

    @Published var tbNickName: String {
        didSet {
            UserDefaults.standard.set(tbNickName, forKey: AppUserKeys.TB_NICK_NAME.rawValue)
        }
    }

    @Published var taoId: String {
        didSet {
            UserDefaults.standard.set(taoId, forKey: AppUserKeys.TAO_ID.rawValue)
        }
    }

    // 渠道ID
    @Published var channelId: String {
        didSet {
            UserDefaults.standard.set(channelId, forKey: AppUserKeys.RELATION_ID.rawValue)
        }
    }


    @Published var agreePrivacy: Bool {
        didSet {
            UserDefaults.standard.set(agreePrivacy, forKey: AppUserKeys.AGREE_PRIVACY.rawValue)
        }
    }


    init() {
        self.uuid = UserDefaults.standard.object(forKey: AppUserKeys.UUID.rawValue) as? String ?? ""

        self.uid = UserDefaults.standard.object(forKey: AppUserKeys.UID.rawValue) as? String ?? ""

        self.mobile = UserDefaults.standard.object(forKey: AppUserKeys.MOBILE.rawValue) as? String ?? ""

        self.token = UserDefaults.standard.object(forKey: AppUserKeys.TOKEN.rawValue) as? String ?? ""

        self.itemSearchHistory = []

        let searchHistory = UserDefaults.standard.object(forKey: AppUserKeys.ItemSearchHistory.rawValue) as? String
        if let history = searchHistory {
            let de = JSONDecoder()
            if let data = history.data(using: .utf8) {
                if let v = try? de.decode([String].self, from: data) {
                    self.itemSearchHistory = v
                }
            }
        }

        self.tbNickName = UserDefaults.standard.object(forKey: AppUserKeys.TB_NICK_NAME.rawValue) as? String ?? ""
        self.taoId = UserDefaults.standard.object(forKey: AppUserKeys.TAO_ID.rawValue) as? String ?? ""
        self.channelId = UserDefaults.standard.object(forKey: AppUserKeys.RELATION_ID.rawValue) as? String ?? ""

        self.agreePrivacy = UserDefaults.standard.object(forKey: AppUserKeys.AGREE_PRIVACY.rawValue) as? Bool ?? false
    }

    // 检测用户是否已经登陆
    public static func checkLogin() -> Bool {
        if (AppUserSettings.shared.token == "") {
            return false
        }
        return true
    }

    /// 添加商品搜索历史
    func addSearchHistory(q: String) {
        if q == "" {
            return
        }

        objc_sync_enter(self)

        // 如果已经存在则不需要添加
        if (itemSearchHistory.contains(q)) {
            objc_sync_exit(self)
            return
        }

        // 保证搜索记录最多有 10 个
        itemSearchHistory.insert(q, at: 0)
        while (itemSearchHistory.count >= 10) {
            itemSearchHistory.removeLast()
        }
        objc_sync_exit(self)
    }
}
