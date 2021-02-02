import SwiftUI
import AuthenticationServices

/// 我的 需要登陆的状态 UI
struct MeContentLoginView: View {
    @Environment(\.colorScheme) var colorScheme

    @ObservedObject var user = AppUserSettings.shared

    var body: some View {
        GeometryReader { reader in
            VStack {
                VStack {
                    headerSettingIconView()
                    headerIconNameUI()
                }.frame(height: reader.size.height / 4)

                Spacer()
            }
        }.edgesIgnoringSafeArea([.top])
    }

    func headerSettingIconView() -> some View {
        HStack {
            Spacer()
            NavigationLink(destination: AppSettingsContentView().navigationBarTitle("设置", displayMode: .inline).navigationBarHidden(false).navigationBarBackButtonHidden(false)) {
                Image(systemName: "gear")
            }.buttonStyle(PlainButtonStyle())
            Spacer().frame(width: 30)
        }
    }


    func headerIconNameUI() -> some View {
        let w: CGFloat = 48

        return HStack {
            Spacer().frame(width: w)
            Image("me_logo").resizable().frame(width: w, height: w).cornerRadius(w / 2)

            Spacer().frame(width: w / 2)

            HStack {
                NavigationLink(destination: UserAuthContentView().navigationBarTitle("用户登录", displayMode: .inline)) {
                    Text("登录/注册")
                }
                Spacer()
            }
            Spacer()
        }
            .frame(height: 48)
    }
}


#if DEBUG
struct MeContentLoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MeContentLoginView()

            MeContentLoginView().environment(\.colorScheme, .dark)
        }
    }
}
#endif

