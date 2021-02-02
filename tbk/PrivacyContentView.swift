import SwiftUI

/**
 * 隐私页面
 */
struct PrivacyContentView: View {

    /// 是否显示自己
    @Binding var showThis: Bool

    /// 是否展示 同意/不同意 按钮
    @State var showButtons: Bool = false

    /// 展示提示
    @State var showActionSheet = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("奇遇淘客隐私协议").font(.largeTitle)
                Spacer()
            }

            VStack {
                Spacer()
                Text("您的隐私协议").font(.title)
                Spacer()
            }
            if (showButtons) {
                HStack {
                    Button(action: {
                        AppUserSettings.shared.agreePrivacy = true
                        self.showThis = false
                    }, label: {
                        Text("同意").font(.title)
                    })

                    Spacer().frame(width: 30)

                    Button(action: {
                        self.showActionSheet = true
                    }, label: {
                        Text("不同意").font(.title).foregroundColor(.red)
                    })
                }
                    .actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(title: Text("隐私协议"), message: Text("在给您提供服务之前，您必须同意隐私协议"), buttons: [.cancel()])
                    }
            }
        }
    }
}
