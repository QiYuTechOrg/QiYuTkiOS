import Logging
import SwiftUI


enum SmsLoginActionSheet: Identifiable {
    case tip(s: String)

    var id: Int {
        switch self {
        case .tip(s: let s):
            return s.hashValue
        }
    }
}

// 短信登录
struct SmsLoginContentView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var mobile: String = ""
    @State var code: String = ""

    // 获取验证码需要的时间
    // 当 countDown = 0 的时候表示允许获取新的验证码
    // 为 其他值 > 0 的时候，多少秒后允许重新获取
    @State var countDown: Int = 0

    @State var actionTip: SmsLoginActionSheet? = nil

    // 展示隐私协议
    @State var showPrivacy = false

    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var logger = Logging.Logger(label: "短信登录")

    var body: some View {
        Form {
            Section {
                HStack {
                    TextField("手机号码", text: $mobile).keyboardType(.phonePad)
                    Button(action: {
                        if (countDown == 0) {
                            self.getSmsCode()
                        } else {
                            self.actionTip = .tip(s: "请 \(countDown) 秒后重新获取验证码")
                        }
                    }, label: {
                        if (countDown == 0) {
                            Text("获取验证码")
                        } else {
                            Text("\(countDown)s")
                        }
                    })
                }

                TextField("验证码", text: $code).keyboardType(.numberPad)
            }

            Section {
                HStack {
                    Button(action: {
                        self.smsLogin()
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
        }
            .actionSheet(item: self.$actionTip, content: { tip in
                switch tip {
                case .tip(s: let s):
                    return ActionSheet(
                        title: Text("奇遇淘客提示您"),
                        message: Text(s),
                        buttons: [.default(Text("确认"))])
                }
            })
            .sheet(isPresented: $showPrivacy, content: {
                PrivacyContentView(showThis: $showPrivacy)
            })
            .onDisappear(perform: {
                // 关闭 timer
                self.timer.upstream.connect().cancel()
            })
            .onReceive(timer, perform: { input in
                if (countDown <= 0) {
                    return
                }
                countDown -= 1
            })
    }

    // 获取验证码
    func getSmsCode() {
        self.actionTip = .tip(s: "功能已移除")

    }

    func smsLogin() {
        guard self.mobile.count == 11 else {
            self.actionTip = .tip(s: "请您先输入手机号码")
            return
        }
        guard self.code.count >= 4 else {
            self.actionTip = .tip(s: "请输入正确的验证码")
            return
        }

        self.actionTip = .tip(s: "功能已移除")

    }
}

#if DEBUG
struct SmsLoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        SmsLoginContentView()
    }
}
#endif
