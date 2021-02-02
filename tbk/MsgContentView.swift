import SwiftUI

enum MsgType: String {
    case system
    case user
}

/// 消息内容界面
struct MsgContentView: View {
    @State var msgType: MsgType

    var body: some View {
        VStack {
            HStack {
                if msgType == .system {
                    Text("系统消息")
                        .frame(maxWidth: .infinity)

                    Button("用户消息") {
                        self.msgType = .user
                    }
                        .frame(maxWidth: .infinity)
                } else {
                    Button("系统消息") {
                        self.msgType = .system
                    }
                        .frame(maxWidth: .infinity)

                    Text("用户消息")
                        .frame(maxWidth: .infinity)
                }
            }
                .frame(height: 30)

            if self.msgType == .system {
                MyMsgWebView(msgType: .system)
            } else {
                if AppUserSettings.checkLogin() {
                    MyMsgWebView(msgType: .user)
                } else {
                    VStack {
                        Spacer().frame(height: 30)
                        Text("您尚未登陆")
                        Spacer()
                    }
                }
            }
        }
    }
}

#if DEBUG
struct MsgContentView_Previews: PreviewProvider {
    static var previews: some View {
        MsgContentView(msgType: .user)
    }
}
#endif
