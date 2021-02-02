import SwiftUI
import Logging

/// 商品搜索详情列表
struct ShopSearchDetailContentView: View {
    let q: String

    var logger = Logging.Logger(label: "商品搜索详情")

    private static var black_list = [
        "腾讯", "Q币", "q币", "视频",
        "dnf", "DNF", "QQ音乐", "qq音乐",
        "VIP", "vip", "会员",
        "优酷", "土豆", "爱奇艺",
        "百度", "baidu"
    ];

    @ObservedObject var viewModel = MySearchViewModel.shared

    func getSearchContent() -> AnyView {
        var in_black = false

        ShopSearchDetailContentView.black_list.forEach({ content in
            if q.contains(content) {
                in_black = true
            }
        })

        if in_black {
            return AnyView(Group {
                Spacer().frame(height: 30)
                Text("没有找到您搜索的商品")
                Spacer()
            })
        } else {
            return AnyView(MyItemSearchWebView(q: self.q, viewModel: viewModel))
        }
    }

    var body: some View {
        VStack {
            Text("\(q)").font(.title)

            getSearchContent()
        }
            .sheet(isPresented: $viewModel.openItem, content: {
                ItemDetailContentView()
            })
    }
}

#if DEBUG
struct ShopItemSearchDetailContentView_Previews: PreviewProvider {
    static var previews: some View {
        ShopSearchDetailContentView(q: "鞋子")
    }
}
#endif
