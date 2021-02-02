import SwiftUI

import Logging

import SwiftUIRefresh


// 优惠券
// 猜你细化接口
struct CouponGuessYouLike: View {

    var logger = Logging.Logger(label: "猜你喜欢")

    var body: some View {
        GenericInfiniteList<ApiDtTbkItemInfo>(
            column: 2,
            loadingHandler: { firstTime, pageId, loading, noMoreData, dl in
                self.loadingData(firstTime: firstTime, pageId: pageId, loading: loading, noMoreData: noMoreData, dl: dl)
            },
            renderRowHandler: { binding, i, size in
                return self.getHStack(dataList: binding, row: i, size: size)
            },
            renderEmptyHandler: {
                return AnyView(Text("-- 获取商品信息失败 --").font(.largeTitle))
            }
        )
    }

    private func loadingData(
        firstTime: Bool,
        pageId: Binding<Int>,
        loading: Binding<Bool>,
        noMoreData: Binding<Bool>,
        dl: Binding<[ApiDtTbkItemInfo]>
    ) {
        if firstTime && dl.wrappedValue.count > 0 {
            return
        }

        let pid = pageId.wrappedValue
        pageId.wrappedValue += 1

        logger.info("fetch page: \(pid)")

        let args = ApiDtGoodsExplosiveGoodsListArgs(
            pageId: pid.description,
            pageSize: "20",
            PriceCid: nil,
            cids: nil
        )

        ApiDtkGuessYouLikeStub.my_post(args: args, failure_cb: {
            logger.error("fetch page \(pid) failed")
            loading.wrappedValue = false
            noMoreData.wrappedValue = true
        }) { ret in
            loading.wrappedValue = false

            guard ret.errno == 0, let data = ret.data else {
                logger.error("获取商品信息失败: \(ret)")
                noMoreData.wrappedValue = true
                return
            }

            dl.wrappedValue += data
        }
    }


    func getItemView(dataList: Binding<[ApiDtTbkItemInfo]>, row: Int, column: Int, imgWidth: CGFloat) -> AnyView {
        if ((row * 2 + column) >= dataList.wrappedValue.count) {
            return AnyView(EmptyView())
        }

        let item = dataList.wrappedValue[row * 2 + column]

        return AnyView(
            NavigationLink(destination: TbkItemDetailContentView(itemId: item.tao_id)
                .navigationBarTitle(Text(item.title_short), displayMode: .inline)) {

                TbkItemInfoTwoColumnView(item: item, imgWidth: imgWidth)
            }.buttonStyle(PlainButtonStyle()).cornerRadius(8)
        )
    }


    func getHStack(dataList: Binding<[ApiDtTbkItemInfo]>, row: Int, size: CGSize) -> AnyView {
        let edgeSpace: CGFloat = 5
        let imgWidth: CGFloat = (size.width - edgeSpace * 4) / 2

        if (imgWidth < 1.0) {
            logger.error("image width: \(imgWidth)")
            return AnyView(EmptyView())
        }

        return AnyView(ScrollView {
            HStack(spacing: 0) {
                Spacer().frame(width: edgeSpace)
                getItemView(dataList: dataList, row: row, column: 0, imgWidth: imgWidth)
                Spacer().frame(width: edgeSpace * 2)
                getItemView(dataList: dataList, row: row, column: 1, imgWidth: imgWidth)
                Spacer().frame(width: edgeSpace)
            }
        })
    }
}

#if DEBUG
struct CouponGuessYouLike_Previews: PreviewProvider {
    static var previews: some View {
        CouponGuessYouLike()
    }
}
#endif
