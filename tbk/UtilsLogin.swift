import Foundation

// 登陆状态
enum LoginState {
    // 没有登陆
    case none

    // mob 相关的错误
    case mob_permission
    case mob_pre_login
    case mob_login

    case server_errno
    case server_data

    // 登陆成功
    case success
}
