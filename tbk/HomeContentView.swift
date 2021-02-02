import Foundation
import SwiftUI


/// 主页的 sheet 展示
enum HomeSheetEnum: Identifiable {
    // 商品详情
    case itemDetail
    // 系统消息
    case message

    var id: Int {
        self.hashValue
    }
}

///
/// 主界面的 UI
///
struct HomeContentView: View {

    @ObservedObject var viewModel = MyViewModel.home_shared

    @State var homeSheet: HomeSheetEnum? = nil

    var body: some View {
        VStack(spacing: 20) {
            HomeHeaderView("奇遇淘客").frame(height: 80)

            ScrollView(showsIndicators: false) {
                VStack {
                    // 公告信息
                    HomeAnnouncementView()

                    VStack {
                        Text("您自己的内容").font(.largeTitle)
                    }
                }
            }
        }.edgesIgnoringSafeArea([.top])
    }

    func getSheetPage(item: HomeSheetEnum) -> AnyView {
        switch item {
        case .itemDetail: do {
            return AnyView(ItemDetailContentView())
        }
        case .message: do {
            return AnyView(MsgContentView(msgType: .system))
        }
        }
    }


    static func make_spacer() -> some View {
        Spacer().frame(width: 20)
    }
}

#if DEBUG
struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView()
    }
}
#endif
