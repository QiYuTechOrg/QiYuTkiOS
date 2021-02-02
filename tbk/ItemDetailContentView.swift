import SwiftUI
import Logging


/// 我们可能会有多个 actionSheet
enum ItemDetailActionSheetEnum: Identifiable {

    case buyNotLogin      // 购买的时候没有登陆
    case buyNotBindTaoBao // 购买的时候没有绑定淘宝

    case shareNotLogin      // 分享的时候没有登陆
    case shareNotBindTaoBao // 分享的时候没有绑定淘宝

    case tipMsg // 任何 通知的消息

    var id: Int {
        self.hashValue
    }
}


/// 商品详情的页面
/// @deprecated use TbkItemDetailContentView
struct ItemDetailContentView: View {

    // 全局唯一值 [防止 传递 item_id 失败]
    // empty 表示为空
    public static var g_item_id: String = ""

    static var logger = Logger(label: "商品详情")

    /// 所有的 actionSheet 都使用此表达
    @State var actionSheet: ItemDetailActionSheetEnum? = nil
    @State var tipMsg = ""

    @State var showShareSheet = false

    init() {
        Self.logger.info("open item \(Self.g_item_id)")
    }

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
        buy.buyItem(itemId: Self.g_item_id)
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
        buy.buyItem(itemId: Self.g_item_id)
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
        share.shareItem(itemId: Self.g_item_id)
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
        share.shareIosItem(itemId: Self.g_item_id)
    }

    var body: some View {
        VStack {
            MyItemDetailWebView(item_id: Self.g_item_id)
            HStack {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("分享")
                }
                    .frame(maxWidth: 100)
                    .onTapGesture {
                        self.doShareItem()
                    }

                Button(action: {
                    self.doBuyItem()
                }, label: {
                    Text("立即购买")
                })
                    .buttonStyle(PlainButtonStyle())
                    .frame(maxHeight: .infinity)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(50)
            }
                .frame(height: 40)
                .padding()
        }
            .actionSheet(item: $actionSheet) { item in
                self.getActionSheet(item: item)
            }
            .sheet(isPresented: $showShareSheet) {
                let tkl = TaoBaoShareLogic.tkl
                if tkl != "" {
                    ShareContentView(activityItems: [tkl])
                } else {
                    ShareContentView(activityItems: ["获取淘口令失败"])
                }
            }
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
}

#if DEBUG
struct ItemDetailContentView_Previews: PreviewProvider {
    init() {
        ItemDetailContentView.g_item_id = "588019991078";
    }

    static var previews: some View {
        ItemDetailContentView()
    }
}
#endif
