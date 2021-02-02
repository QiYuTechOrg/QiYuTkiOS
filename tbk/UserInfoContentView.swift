import SwiftUI


/// 用户信息展示
struct UserInfoContentView: View {
    @ObservedObject var user = AppUserSettings.shared

    var body: some View {
        Form {
            Section(header: Text("账号信息")) {
                getHStackInfo(k: "手机号码", v: user.mobile)
                getHStackInfo(k: "淘宝ID", v: user.taoId)
                getHStackInfo(k: "渠道ID", v: user.channelId)
            }
        }
    }

    private func getHStackInfo(k: String, v: String) -> some View {
        return HStack {
            Text(k).frame(width: 120)
            Text(v)
        }
    }
}

#if DEBUG
struct UserInfoContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoContentView()
    }
}
#endif
