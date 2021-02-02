import Foundation


enum AppKeys: String {
    case DeviceToken = "APP_DEVICE_TOKEN"
}

// UserDefaults.standard keys
enum AppUserKeys: String {
    // 给每个设备一个 唯一标志
    // 每次安装一个 APP 一直都是唯一的
    case UUID = "UUID"

    /// 服务器端 UUID 表示拥护的唯一标志
    case UID = "UID"
    // 用户的手机号码 [登陆之后才会有]
    case MOBILE = "MOBILE"
    // 用户的 token [登陆之后才会有]
    case TOKEN = "TOKEN"

    // 商品搜索历史记录
    case ItemSearchHistory = "ITEM_SEARCH_HISTORY"

    // 淘宝昵称
    case TB_NICK_NAME = "TB_NICKNAME"
    // 淘宝的 ID
    case TAO_ID = "TAO_ID"
    // 使用 relation_id 表示是否已经绑定了淘宝
    case RELATION_ID = "RELATION_ID"


    /// 同意隐私协议
    case AGREE_PRIVACY = "AGREE_PRIVACY"
}
