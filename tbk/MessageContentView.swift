import SwiftUI

import Logging


// 用户消息
struct UserMessageView: View {

    let logger = Logging.Logger(label: "用户消息")

    var body: some View {
        Text("功能已移除").font(.largeTitle)
    }
}

// 系统消息
struct SysMessageView: View {

    let logger = Logging.Logger(label: "系统消息")

    var body: some View {
        Text("功能已移除").font(.largeTitle)
    }
}

/// 消息界面
struct MessageContentView: View {
    var body: some View {
        TabView {
            SysMessageView()
                .tabItem {
                    Image(systemName: "message.circle")
                    Text("系统消息")
                }

            UserMessageView()
                .tabItem {
                    Image(systemName: "person.2.circle.fill")
                    Text("用户消息")
                }
        }
    }
}

#if DEBUG
struct MessageContentView_Previews: PreviewProvider {
    static var previews: some View {
        MessageContentView()
    }
}
#endif
