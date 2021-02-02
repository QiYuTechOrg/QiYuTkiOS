import SwiftUI

import Logging


struct TbkSearchResultTabView: View {
    let q: String

    let sort: String?

    let logger = Logging.Logger(label: "淘宝客搜索")

    var body: some View {
        GenericInfiniteList<ApiDtTbkItemInfo>(column: 1) { firstTime, pageId, loadingState, noMore, dataList in
            return self.loadingDataHandler(firstTime: firstTime, pageId: pageId, loadingState: loadingState, noMore: noMore, dataList: dataList)
        } renderRowHandler: { dl, row, size in
            return self.renderRowHandler(dataList: dl.wrappedValue, row: row, size: size)
        } renderEmptyHandler: {
            return self.renderEmptyHandler()
        }
    }

    private func loadingDataHandler(firstTime: Bool, pageId: Binding<Int>, loadingState: Binding<Bool>, noMore: Binding<Bool>, dataList: Binding<[ApiDtTbkItemInfo]>) {
        if (firstTime && dataList.wrappedValue.count > 0) {
            return
        }

        let form = ApiDtGoodsListSuperGoodsArgs(
            pageId: pageId.wrappedValue.description,
            pageSize: "20",
            keyWords: self.q,
            type: "0",
            tmall: nil,
            haitao: nil,
            sort: self.sort,
            specialId: nil,
            channelId: AppUserSettings.shared.channelId
        )

        pageId.wrappedValue += 1
        logger.info("fetch page: \(form.pageId)")

        ApiDtkSuperSearchStub.my_post(args: form) {
            logger.error("搜索失败: \(form)")
            noMore.wrappedValue = true
            loadingState.wrappedValue = false
        } success_cb: { (ret) in
            loadingState.wrappedValue = false

            guard ret.errno == 0, let data = ret.data else {
                noMore.wrappedValue = true
                return
            }
            if (data.count <= 0) {
                noMore.wrappedValue = true
            }

            dataList.wrappedValue += data
        }
    }

    private func renderRowHandler(dataList: [ApiDtTbkItemInfo], row: Int, size: CGSize) -> AnyView {
        if (row >= dataList.count) {
            return AnyView(EmptyView())
        }

        let item = dataList[row]

        return AnyView(ScrollView {
            NavigationLink(destination: TbkItemDetailContentView(itemId: item.tao_id)
                .navigationBarTitle(Text(item.title_short), displayMode: .inline)) {

                TbkItemInfoOneColumnView(item: item, imgWidth: size.width / 3)
            }.buttonStyle(PlainButtonStyle())
        })
    }

    private func renderEmptyHandler() -> AnyView {
        return AnyView(VStack {
            Text("-- 没有搜索到数据 -- ").font(.largeTitle)
        })
    }
}


/// 淘宝客搜索结果
struct TbkSearchResultContentView: View {
    var q: String

    var body: some View {
        TabView {
            TbkSearchResultTabView(q: self.q, sort: nil)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("综合")
                }
            TbkSearchResultTabView(q: self.q, sort: "total_sales_des")
                .tabItem {
                    Image(systemName: "number.square")
                    Text("销量")
                }
            TbkSearchResultTabView(q: self.q, sort: "price_asc")
                .tabItem {
                    Image(systemName: "yensign.square")
                    Text("价格")
                }
        }
    }
}

#if DEBUG
struct TbkSearchResultContentView_Previews: PreviewProvider {
    static var previews: some View {
        TbkSearchResultContentView(q: "衣服")
    }
}
#endif
