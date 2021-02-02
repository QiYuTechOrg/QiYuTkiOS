import Logging
import SwiftUI

//
struct RankTypeView: View {

    let rankType: Int

    let logger = Logging.Logger(label: "榜单推荐商品")

    var body: some View {
        GenericInfiniteList<ApiDtTbkItemInfo>(
            dataList: [],
            pageId: 1,
            loadingState: true,
            column: 1,
            loadingHandler: { firstTime, pageId, loadingState, noMore, dataList in
                self.loadingDataHandler(firstTime: firstTime, pageId: pageId,
                    loadingState: loadingState, noMoreData: noMore, dataList: dataList)
            },
            renderRowHandler: { dl, row, size in
                return self.renderRowHandler(dl: dl.wrappedValue, row: row, size: size)
            })
    }

    func loadingDataHandler(firstTime: Bool,
                            pageId: Binding<Int>,
                            loadingState: Binding<Bool>,
                            noMoreData: Binding<Bool>,
                            dataList: Binding<[ApiDtTbkItemInfo]>) {
        if (firstTime && dataList.wrappedValue.count > 0) {
            return
        }

        let pid = pageId.wrappedValue
        pageId.wrappedValue += 1

        logger.info("fetch page: \(pid)")

        let args = ApiDtGoodsGetRankingListArgs(
            rankType: "\(self.rankType)",
            cid: nil,
            pageSize: "20",
            pageId: pid.description
        )

        ApiDtkRankingListStub.my_post(args: args, failure_cb: {
            loadingState.wrappedValue = false
            noMoreData.wrappedValue = true

            logger.error("获取商品信息失败")
        }) { ret in
            loadingState.wrappedValue = false

            guard ret.errno == 0, let data = ret.data else {
                logger.error("服务器错误: \(ret.errmsg)")
                noMoreData.wrappedValue = true
                return
            }

            dataList.wrappedValue += data
        }
    }

    func renderRowHandler(dl: [ApiDtTbkItemInfo], row: Int, size: CGSize) -> AnyView {
        let item = dl[row]

        return AnyView(ScrollView {
            NavigationLink(destination: TbkItemDetailContentView(itemId: item.tao_id)
                .navigationBarTitle(Text(item.title_short), displayMode: .inline)) {

                TbkItemInfoOneColumnView(item: item, imgWidth: size.width / 3)
            }.buttonStyle(PlainButtonStyle())
        })
    }
}

// 淘宝客榜单推荐 模块
struct TbkRecommendContentView: View {
    var logger = Logging.Logger(label: "热销榜单")

    var rankList = ["实时榜", "全天榜", "热推榜", "复购榜", "热词飙升榜", "热词排行榜", "综合热搜榜"]

    var body: some View {
        TabView {
            RankTypeView(rankType: 1)
                .tabItem {
                    Image(systemName: "timer")
                    Text(rankList[0])
                }

            RankTypeView(rankType: 2)
                .tabItem {
                    Image(systemName: "calendar.circle")
                    Text(rankList[1])
                }

            RankTypeView(rankType: 3)
                .tabItem {
                    Image(systemName: "flame")
                    Text(rankList[2])
                }

            RankTypeView(rankType: 4)
                .tabItem {
                    Image(systemName: "person.circle")
                    Text(rankList[3])
                }

            // getRankTabItem(rType: 5)
            // getRankTabItem(rType: 6)
            // getRankTabItem(rType: 7)
            RankTypeView(rankType: 7)
                .tabItem {
                    Image(systemName: "list.dash")
                    Text(rankList[6])
                }

        }
    }
}

#if DEBUG
struct TbkRecommendContentView_Previews: PreviewProvider {
    static var previews: some View {
        TbkRecommendContentView()
    }
}
#endif
