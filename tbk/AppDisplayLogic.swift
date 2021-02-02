import Foundation

// 通用展示的逻辑处理类
class AppDisplayLogic: ObservableObject {
    /// 我们使用全局的
    static let shared = AppDisplayLogic()

    var displayName: String {
        let user = AppUserSettings.shared
        if (user.tbNickName != "") {
            return user.tbNickName
        }
        return app_const_name
    }

    init() {
    }
}
