import Foundation
import SwiftUI

///
/// 我的界面 UI
///
/// 主要界面分两种:
/// * 未登陆的
/// * 已登陆的
///
struct MeContentMainView: View {

    @ObservedObject var user = AppUserSettings.shared

    @State var isLogin = AppUserSettings.checkLogin()

    var body: some View {
        getView()
            .onReceive(AppUserSettings.shared.$token) { v in
                self.isLogin = v != ""
            }
    }

    func getView() -> AnyView {
        if isLogin {
            return AnyView(MeContentLoggedView())
        } else {
            return AnyView(MeContentLoginView())
        }
    }
}


#if DEBUG
struct MeContentView_Previews: PreviewProvider {
    static var previews: some View {
        MeContentMainView()
    }
}
#endif
