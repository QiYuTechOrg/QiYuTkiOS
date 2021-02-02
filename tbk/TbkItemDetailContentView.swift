import SwiftUI

import Logging


struct TbkItemShowView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    let item: ApiDtTbkItemInfo

    let screenWidth = UIScreen.main.bounds.width

    /// 所有的 actionSheet 都使用此表达
    @State var actionSheet: ItemDetailActionSheetEnum? = nil
    @State var tipMsg = ""

    @State var showShareSheet = false

    private func getRootViewController() -> UIViewController {
        UIApplication.shared.windows.first!.rootViewController!
    }

    func doBuyItem() {
        guard UserLogic.checkLogin() else {
            self.actionSheet = .buyNotLogin
            return
        }
        guard UserLogic.checkBindTaoBao() else {
            self.actionSheet = .buyNotBindTaoBao
            return
        }

        let buy = TaoBaoBuyLogic(controller: self.getRootViewController())
        buy.buyItem(itemId: self.item.tao_id)
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    itemHeader()

                    showShopInfo()
                    showShopScore()

                    if let details = item.tao_details {
                        ForEach(details, id: \.self) { (s: String) in
                            NetworkImageViewV3(url: s, width: screenWidth * 0.9)
                        }
                    }
                }
            }.frame(maxHeight: .infinity)

            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "house")
                        Text("主页")
                    }.frame(width: 80)
                })

                Button(action: {
                    self.doShareItem()
                }, label: {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("分享")
                    }.frame(width: 80)
                })

                Button(action: {
                    self.doBuyItem()
                }, label: { Text("立刻购买") }
                )
                    .frame(width: 180, height: 40)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(20)
            }.frame(height: 60)
        }.actionSheet(item: $actionSheet) { item in
            self.getActionSheet(item: item)
        }.sheet(isPresented: $showShareSheet) {
            let tkl = TaoBaoShareLogic.tkl
            if tkl != "" {
                ShareContentView(activityItems: [tkl])
            } else {
                ShareContentView(activityItems: ["获取淘口令失败"])
            }
        }
    }

    /// 分享商品
    func doShareItem() {
        guard UserLogic.checkLogin() else {
            self.actionSheet = .shareNotLogin
            return
        }

        guard UserLogic.checkBindTaoBao() else {
            self.actionSheet = .shareNotBindTaoBao
            return
        }

        let share = TaoBaoShareLogic(
            tipMsg: $tipMsg,
            tipActionSheet: $actionSheet,
            showShareSheet: $showShareSheet
        )
        share.shareItem(itemId: self.item.tao_id)
    }

    func doShareIosItem() {
        guard UserLogic.checkLogin() else {
            self.actionSheet = .shareNotLogin
            return
        }

        let share = TaoBaoShareLogic(
            tipMsg: $tipMsg,
            tipActionSheet: $actionSheet,
            showShareSheet: $showShareSheet
        )
        share.shareIosItem(itemId: self.item.tao_id)
    }

    /// 不进行淘宝渠道 ID 是否绑定的检测
    /// 这样会导致一个问题:
    /// 用户购买之后可能无法给它积分
    ///
    /// 但是应该可以获取到订单
    ///
    func doBuyWithoutTaoBaoBind() {
        guard UserLogic.checkLogin() else {
            self.actionSheet = .buyNotLogin
            return
        }

        let buy = TaoBaoBuyLogic(controller: self.getRootViewController())
        buy.buyItem(itemId: self.item.tao_id)
    }

    ///
    /// - Parameter item:
    /// - Returns:
    func getActionSheet(item: ItemDetailActionSheetEnum) -> ActionSheet {
        switch (item) {
        case .buyNotLogin: do {
            return ActionSheet(title: Text(app_const_tip),
                message: Text("需要登陆"),
                buttons: [.default(Text("确认"))])
        }
        case .buyNotBindTaoBao: do {
            return ActionSheet(title: Text("尚未绑定淘宝"),
                message: Text("您当前没有绑定淘宝账号."),
                buttons: [
                    .destructive(Text("继续购买"), action: { self.doBuyWithoutTaoBaoBind() }),
                    .cancel()
                ])
        }
        case .shareNotLogin: do {
            return ActionSheet(title: Text(app_const_tip),
                message: Text("需要登陆"),
                buttons: [.default(Text("确认"))])
        }
        case .shareNotBindTaoBao: do {
            return ActionSheet(title: Text("尚未绑定淘宝"),
                message: Text("您当前没有绑定淘宝账号."),
                buttons: [
                    .destructive(Text("继续分享"), action: { self.doShareIosItem() }),
                    .cancel()
                ])
        }
        case .tipMsg: do {
            return ActionSheet(title: Text(app_const_tip),
                message: Text(self.tipMsg),
                buttons: [.default(Text("确认"))])
        }
        }
    }

    private func itemHeader() -> AnyView {
        return AnyView(HStack(spacing: 0) {
            Spacer().frame(width: screenWidth * 0.05)
            VStack {
                NetworkImageViewV3(url: item.tao_img, width: screenWidth * 0.9)
                HStack {
                    Text(String(format: "¥ %.1f", arguments: [item.price_actual])).foregroundColor(.red)
                    Text(String(format: "¥ %.1f", arguments: [item.price_origin])).strikethrough()
                    Spacer()
                    Text("月销: \(item.sale_month ?? 0)")
                }
                Text(item.title_long).lineLimit(2)
            }.cornerRadius(10)
            Spacer().frame(width: screenWidth * 0.05)
        })
    }

    private func showShopInfo() -> AnyView {
        let width: CGFloat = 60

        return AnyView(VStack(alignment: .leading, spacing: 0, content: {
            HStack {
                Spacer().frame(width: 20)
                NetworkImageViewV3(url: self.item.seller_logo ?? "", width: width).cornerRadius(width / 2)
                Spacer().frame(width: 10)
                Text(item.seller_name ?? "店铺名称").font(.callout)
                Spacer()
            }
        }))
    }

    private func showShopScore() -> some View {
        return HStack {
            Spacer().frame(width: 20)
            self.renderScore(name: "宝贝描述", s: self.item.score_dsr ?? 0)
            self.renderScore(name: "卖家服务", s: self.item.score_service ?? 0)
            self.renderScore(name: "物流服务", s: self.item.score_ship ?? 0)
            Spacer().frame(width: 20)
        }
    }

    private func renderScore(name: String, s: Float) -> AnyView {
        return AnyView(HStack {
            Text("\(name):").font(.system(size: 16))
            Text(String(format: "%.2f", arguments: [s])).font(.system(size: 16)).foregroundColor(.red)
        }.frame(maxWidth: .infinity))
    }
}

/// 淘宝客商品详情
struct TbkItemDetailContentView: View {

    let itemId: String

    @State var loading = true
    @State var detail: ApiDtTbkItemInfo? = nil

    let logger = Logging.Logger(label: "商品详情")

    var body: some View {
        VStack {
            if (loading) {
                MyActivityIndicator()
            } else if let info = self.detail {
                TbkItemShowView(item: info)
            } else {
                Text("获取商品信息失败: \(itemId)")
            }
        }
            .onAppear {
                self.loadingItemDetailInfo()
            }
    }

    private func loadingItemDetailInfo() {
        let form = ApiDtTbkItemDetailForm(tao_id: itemId)
        ApiTbkItemDetailStub.my_post(args: form, failure_cb: {
            self.loading = false
            self.logger.error("获取商品详情失败: \(self.itemId)")
        }) { ret in
            self.loading = false

            guard ret.errno == 0, let data = ret.data else {
                return
            }

            self.detail = data
        }
    }
}

#if DEBUG
struct TbkItemDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        let itemId = "hello"
        TbkItemDetailContentView(itemId: itemId)
    }
}
#endif
