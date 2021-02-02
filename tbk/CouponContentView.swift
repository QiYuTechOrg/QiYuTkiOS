import SwiftUI


/// 优惠券搜索页面
struct CouponSearchView: View {
    @Environment(\.colorScheme) var colorScheme

    @State var q = ""
    @State var openSearchPage = false

    var edgeSpace: CGFloat

    var body: some View {
        HStack {
            Spacer().frame(width: edgeSpace)
            NavigationLink(destination: MessageContentView()
                .navigationBarTitle(Text("消息"), displayMode: .inline)) {
                Image(systemName: "ellipsis.bubble").resizable().frame(width: 36, height: 36)
            }.buttonStyle(PlainButtonStyle())
            Spacer().frame(width: edgeSpace)
            NavigationLink(destination: TbkSearchContentView()
                .navigationBarTitle(Text("搜索"), displayMode: .inline), label: {

                MySearchField(text: $q, openSearchPage: $openSearchPage, allowEdit: false)
                    .frame(height: 36)
            })
            Spacer().frame(width: edgeSpace)
        }
    }
}


/// 间隔线图 间断线
struct CouponDashLineView: View {
    @Environment(\.colorScheme) var colorScheme

    func getDashColor() -> Color {
        return MyColorUtils.getTextDefaultColor(scheme: colorScheme)
    }


    var body: some View {
        GeometryReader { proxy in
            VStack {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: proxy.size.width, y: 0))
                }
                    .stroke(style: StrokeStyle(lineWidth: 5, dash: [5]))
                    .foregroundColor(self.getDashColor())
            }
        }.frame(height: 5)
    }
}


/// 优惠券主界面
struct CouponContentView: View {

    var body: some View {
        VStack {
            // 商品搜索界面
            CouponSearchView(edgeSpace: 10)
            // 淘宝客导航界面
            CouponNavButtonsView()
            // 分割线
            CouponDashLineView()
            // 猜你喜欢模块
            CouponGuessYouLike()
        }
    }
}

#if DEBUG
struct CouponContentView_Previews: PreviewProvider {
    static var previews: some View {
        CouponContentView()
    }
}
#endif
