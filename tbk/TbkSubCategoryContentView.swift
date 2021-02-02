import SwiftUI

import Logging

/// 淘宝客 子分类
struct TbkSubCategoryContentView: View {
    let subCid: String

    let logger = Logging.Logger(label: "超级分类")

    var body: some View {
        GenericInfiniteList<ApiDtTbkItemInfo>(
            column: 1,
            loadingHandler: { firstTime, pageId, loading, noMoreData, dl in
                self.loadingData(firstTime: firstTime, pageId: pageId, loading: loading, noMoreData: noMoreData, dl: dl)
            },
            renderRowHandler: { binding, i, size in
                return self.renderRowHandler(dl: binding, row: i, size: size)
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

        let form = ApiDtGoodsGetGoodsListArgs(
            pageId: pid.description,
            pageSize: "20",
            sort: nil,
            cids: nil,
            subcid: subCid,
            juHuaSuan: nil, taoQiangGou: nil, tmall: nil, tchaoshi: nil, goldSeller: nil,
            haitao: nil, pre: nil, brand: nil, brandIds: nil, priceLowerLimit: nil,
            priceUpperLimit: nil, commissionRateLowerLimit: nil,
            monthSalesLowerLimit: nil, specialId: nil,
            freeshipRemoteDistrict: nil, couponPriceLowerLimit: nil, preSale: nil
        )

        ApiDtkGoodsListStub.my_post(args: form, failure_cb: {
            logger.error("fetch \(pid) failed")
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

    private func renderRowHandler(dl: Binding<[ApiDtTbkItemInfo]>, row: Int, size: CGSize) -> AnyView {
        let dataList = dl.wrappedValue

        if row >= dataList.count {
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
}

#if DEBUG
struct TbkSubCategoryContentView_Previews: PreviewProvider {
    static var previews: some View {
        TbkSubCategoryContentView(subCid: "hello")
    }
}
#endif
