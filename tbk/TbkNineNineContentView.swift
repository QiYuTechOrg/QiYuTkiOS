import SwiftUI

import Logging

struct TbkItemInfoOneColumnView: View {
    @Environment(\.colorScheme) var colorScheme

    var item: ApiDtTbkItemInfo

    var imgWidth: CGFloat // 图片的宽度 [高度也是宽度]

    init(item: ApiDtTbkItemInfo, imgWidth: CGFloat) {
        self.item = item

        self.imgWidth = imgWidth
    }

    var body: some View {
        HStack(alignment: .top) {
            NetworkImageViewV3(url: item.tao_img, width: imgWidth, op: .fill)
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title_short)
                    .multilineTextAlignment(.leading)
                    .font(.callout)
                    .lineLimit(2)

                HStack {
                    TbkShared.getCouponAndPriceHStack(colorScheme: colorScheme, price: item.price_coupon)
                    Spacer()
                }

                HStack {
                    Text(String(format: "¥ %.1f", arguments: [item.price_actual])).foregroundColor(.red)
                    Spacer()
                    Text(String(format: "¥ %.1f", arguments: [item.price_origin])).strikethrough().font(.callout)
                }

                HStack {
                    Text(item.seller_name ?? "***").lineLimit(1).font(.system(size: 16))
                    Spacer()
                    Group {
                        Text("月销:").font(.system(size: 16))
                        Text("\(item.sale_month ?? 0)").font(.system(size: 16))
                    }.foregroundColor(MyColorUtils.getTextGrayColor(scheme: colorScheme))
                }
            }
            Spacer().frame(width: 10)
        }.foregroundColor(MyColorUtils.getTextDefaultColor(scheme: colorScheme))
    }
}

// 淘宝客 两列 的展示 商品
struct TbkItemInfoTwoColumnView: View {
    @Environment(\.colorScheme) var colorScheme

    var item: ApiDtTbkItemInfo

    var imgWidth: CGFloat // 图片的宽度 [高度也是宽度]

    init(item: ApiDtTbkItemInfo, imgWidth: CGFloat) {
        self.item = item

        self.imgWidth = imgWidth
    }

    var body: some View {
        VStack {
            NetworkImageViewV3(url: item.tao_img, width: imgWidth, op: .fill)

            VStack(spacing: 10) {
                Text(item.title_short).font(.callout).lineLimit(2).frame(width: imgWidth)

                HStack {
                    TbkShared.getCouponAndPriceHStack(colorScheme: colorScheme, price: item.price_coupon)

                    Spacer()

                    Group {
                        Text("月销:")
                        Text(TbkShared.getMonthSales(monthSales: item.sale_month))
                    }
                }

                HStack {
                    Text(String(format: "¥ %.1f", arguments: [item.price_actual])).foregroundColor(.red)
                    Spacer()
                    Text(String(format: "¥ %.1f", arguments: [item.price_origin])).strikethrough().font(.callout)
                }.foregroundColor(MyColorUtils.getTextGrayColor(scheme: colorScheme))
            }
        }.foregroundColor(MyColorUtils.getTextDefaultColor(scheme: colorScheme))
    }
}


/// 淘宝客 9.9 包邮购
struct TbkNineNineContentView: View {

    let logger = Logging.Logger(label: "9.9包邮购")

    var body: some View {
        GenericInfiniteList<ApiDtTbkItemInfo>(
            loadingState: true,
            column: 2,
            loadingHandler: { firstTime, pageId, loadingState, noMore, dataList in
                if (firstTime && dataList.wrappedValue.count > 1) {
                    return
                }

                let pid = pageId.wrappedValue

                self.logger.info("fetch page: \(pid)")
                pageId.wrappedValue += 1

                let args = ApiDtGoodsNineOpGoodsListArgs(pageId: pid.description, pageSize: "20", nineCid: "1")
                ApiDtkGoodsNineOpGoodsListStub.my_post(args: args, failure_cb: {
                    loadingState.wrappedValue = false // 已经结束
                    noMore.wrappedValue = true
                    self.logger.error("fetch page: \(pid) failed")
                }) { ret in
                    loadingState.wrappedValue = false // 已经结束

                    guard ret.errno == 0, let data = ret.data, data.count > 0 else {
                        self.logger.error("fetch page: \(pid) failed \(ret)")
                        noMore.wrappedValue = true
                        return
                    }

                    dataList.wrappedValue += data
                }
            },
            renderRowHandler: { dataList, row, size in
                return self.renderRowHandler(dataList: dataList.wrappedValue, row: row, size: size)
            })
    }

    private func renderRowHandler(dataList: [ApiDtTbkItemInfo], row: Int, size: CGSize) -> AnyView {
        let edgeSpace: CGFloat = 5
        let imgWidth: CGFloat = (size.width - edgeSpace * 4) / 2


        return AnyView(ScrollView {
            HStack(spacing: 0) {
                Spacer().frame(width: edgeSpace)
                self.renderOneItem(dataList: dataList, row: row, column: 0, imgWidth: imgWidth)
                Spacer().frame(width: edgeSpace * 2)
                self.renderOneItem(dataList: dataList, row: row, column: 1, imgWidth: imgWidth)
                Spacer().frame(width: edgeSpace)
            }
        })
    }

    private func renderOneItem(dataList: [ApiDtTbkItemInfo], row: Int, column: Int, imgWidth: CGFloat) -> AnyView {

        if (row * 2 + column >= dataList.count) {
            return AnyView(EmptyView())
        }

        let item = dataList[row * 2 + column]

        return AnyView(
            NavigationLink(destination: TbkItemDetailContentView(itemId: item.tao_id)
                .navigationBarTitle(Text(item.title_short), displayMode: .inline)) {

                TbkItemInfoTwoColumnView(item: item, imgWidth: imgWidth)
            }.buttonStyle(PlainButtonStyle())
        )
    }
}

#if DEBUG
struct TbkNineNineContentView_Previews: PreviewProvider {
    static var previews: some View {
        TbkNineNineContentView()
    }
}
#endif
