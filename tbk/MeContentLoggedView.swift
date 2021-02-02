import SwiftUI

import Logging

enum MeActivitySheet: Identifiable {
    //   usage  taobao
    case usage, tb

    var id: Int {
        self.hashValue
    }
}

/// 我的 已经登陆的状态 UI
struct MeContentLoggedView: View {

    @Environment(\.colorScheme) var colorScheme

    @State var toastMsg = ""
    @State var toastShow = false

    @State var tbAuthUrl = ""

    @State var meIcon = Image("me_logo")

    @State var activitySheet: MeActivitySheet?

    private func getRootViewController() -> UIViewController {
        UIApplication.shared.windows.first!.rootViewController!
    }

    @ObservedObject var user = AppUserSettings.shared


    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 10) {
                Spacer().frame(height: 30)

                // 设置按钮
                headerSettingIconView()

                // icon 名称
                headerIconNameUI()
            }

            VStack(spacing: 30) {
                orderScoreView()
                authUsageView()
                contactView()
            }

            Spacer()
        }
            .foregroundColor(MyColorUtils.getTextDefaultColor(scheme: colorScheme))
            .onAppear {
                let taoId = self.user.taoId
                AppImageUtils.downloadTaoImage(taoId: taoId) { image in
                    self.meIcon = Image(uiImage: image)
                }
            }
            .alert(isPresented: $toastShow) {
                Alert(title: Text("提示"), message: Text(toastMsg), dismissButton: .default(Text("确认")))
            }
            .sheet(item: $activitySheet, content: { item in
                self.genSheetByItem(item: item)
            })
    }

    func headerIconNameUI() -> some View {
        let w: CGFloat = 48

        return HStack {
            Spacer().frame(width: w)
            NavigationLink(destination: UserInfoContentView()
                .navigationBarTitle(Text("用户信息"), displayMode: .inline)) {

                meIcon.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: w, height: w)
                    .cornerRadius(w / 2)
            }.buttonStyle(PlainButtonStyle())
            Spacer().frame(width: w / 2)

            VStack(alignment: .leading) {
                Text(user.mobile)
                Spacer()
            }
            Spacer()
        }.frame(height: 48)
    }

    func genSheetByItem(item: MeActivitySheet) -> some View {
        switch item {
        case .tb:
            return AnyView(TaoBaoAuthSheet(url: self.tbAuthUrl))
        case .usage:
            return AnyView(UsageContentView())
        }
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

    func orderScoreView() -> some View {
        HStack {
            MeContentUtils.makeSpacer()
            MeContentUtils.vStackWrapper(v: VStack {
                NavigationLink(destination: OrderContentView().navigationBarTitle("订单信息", displayMode: .inline)) {
                    MeContentUtils.lineGen(img: Image(systemName: "cart.circle"), text: Text("我的订单"))
                }.buttonStyle(PlainButtonStyle())
            })
            MeContentUtils.makeSpacer()
        }
    }

    func authUsageView() -> some View {
        HStack {
            MeContentUtils.makeSpacer()
            MeContentUtils.vStackWrapper(v: VStack {
                MeContentUtils.lineGen(img: Image("me_taobao_auth"), text: Text("淘宝授权")).onTapGesture {
                    DispatchQueue.main.async {
                        let tb = TaoBaoAuthLogic(controller: self.getRootViewController())
                        tb.auth(showMsg: self.$toastShow, tipMsg: self.$toastMsg, sheet: self.$activitySheet, tbUrl: self.$tbAuthUrl)
                        // tb.authByUrl(showMsg: self.$toastShow, tipMsg: self.$toastMsg)
                    }
                }
            })
            MeContentUtils.makeSpacer()
        }
    }

    func contactView() -> some View {
        EmptyView()
    }
}

#if DEBUG
struct MeContentLoggedView_Previews: PreviewProvider {
    static var previews: some View {
        MeContentLoggedView()
    }
}
#endif
