import SwiftUI

import Logging

/// 用户/密码登录
struct UserAuthContentView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var username: String = ""
    @State var password: String = ""

    @State var actionTip: SmsLoginActionSheet? = nil

    // 展示隐私协议
    @State var showPrivacy = false

    var logger = Logging.Logger(label: "账号登录")

    var body: some View {
        Form {
            Section {
                TextField("账号", text: $username).keyboardType(.alphabet)

                SecureField("密码", text: $password)
            }

            Section {
                HStack {
                    Button(action: {
                        self.doLogin()
                    }, label: {
                        Text("同意协议并登录")
                    })
                }.frame(maxWidth: .infinity)
            }

            Section {
                HStack {
                    Text("已阅读并同意")
                    Button(action: {
                        self.showPrivacy = true
                    }, label: {
                        Text("《隐私政策》")
                    })
                }
            }
        }.actionSheet(item: self.$actionTip, content: { tip in
            switch tip {
            case .tip(s: let s):
                return ActionSheet(
                    title: Text("奇遇淘客提示您"),
                    message: Text(s),
                    buttons: [.default(Text("确认"))])
            }
        }).sheet(isPresented: $showPrivacy, content: {
            PrivacyContentView(showThis: $showPrivacy)
        })
    }

    func doLogin() {
        let args = ApiDtUserNativeAuthForm(username: self.username, password: self.password)
        ApiUserAuthStub.my_post(args: args, failure_cb: {
            self.actionTip = .tip(s: "请求服务器失败")
        }) { ret in
            guard ret.errno == 0, let data = ret.data else {
                self.actionTip = .tip(s: "登录失败: \(ret.errmsg) (\(ret.errno))")
                return
            }

            let token = data.token

            AppUserSettings.shared.token = token
            UserLogic.fetchUserProfile()
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

#if DEBUG
struct UserAuthContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserAuthContentView()
    }
}
#endif
