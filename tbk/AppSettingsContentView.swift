import SwiftUI
import Logging

#if DEBUG
let app_version = "v1.0.0-dev"
#else
let app_version = "v1.0.0"
#endif

/// 系统设置界面
struct AppSettingsContentView: View {
    let logger = Logger(label: "settings")

    @State var isLogin = AppUserSettings.checkLogin()

    @State var showPrivacySheet = false
    @State var showLogOutActionSheet = false
    @State var showRemoveCacheActionSheet = false

    /**
     * 删除 APP 所有缓存的文件
     */
    func removeAppCacheFiles() {
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileManager = FileManager.default
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: cacheURL, includingPropertiesForKeys: nil, options: [])
            for file in directoryContents {
                do {
                    try fileManager.removeItem(at: file)
                } catch let error as NSError {
                    logger.error("delete filed error: \(error.localizedDescription)")
                }
            }
        } catch let error as NSError {
            logger.error("remove cached failed: \(error.localizedDescription)")
        }
    }


    /// 退出用户登陆
    func userLogOut() {
        UserLogic.logout()
    }

    var body: some View {
        VStack {
            HStack {
                Text("当前版本")
                Spacer()
                Text(app_version)
            }.padding()

            Button(action: {
                self.showRemoveCacheActionSheet = true
            }, label: {
                HStack {
                    Text("清理缓存")
                    Spacer()
                    Image(systemName: "trash")
                }.padding()
            })
                .actionSheet(isPresented: $showRemoveCacheActionSheet) {
                    ActionSheet(title: Text("删除缓存"), message: Text("确认删除所有的缓存文件?"), buttons: [
                        .destructive(Text("确认删除")) {
                            self.removeAppCacheFiles()
                        },
                        .cancel()
                    ])
                }

            Button(action: {
                self.showPrivacySheet = true
            }, label: {
                HStack {
                    Text("隐私协议")
                    Spacer()
                    Image(systemName: "hand.raised")
                }.padding()
            })
                .sheet(isPresented: $showPrivacySheet) {
                    PrivacyContentView(showThis: self.$showPrivacySheet, showButtons: false)
                }


            if isLogin {
                HStack {
                    Spacer()
                    Button(action: {
                        self.showLogOutActionSheet = true
                    }, label: { Text("退出登录") })
                        .actionSheet(isPresented: $showLogOutActionSheet) {
                            ActionSheet(title: Text("退出登陆"), message: Text("您确认退出当前登陆的用户?"), buttons: [
                                .destructive(Text("确认退出").foregroundColor(.red)) {
                                    self.userLogOut()
                                },
                                .cancel()
                            ])
                        }
                    Spacer()
                }
                    .padding()
            } else {
                EmptyView()
            }

            Spacer()
        }
    }
}


#if DEBUG
struct AppSettingsContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppSettingsContentView()
    }
}
#endif
