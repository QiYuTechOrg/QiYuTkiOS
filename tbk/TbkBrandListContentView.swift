import SwiftUI

import Logging

// 淘宝客超值大牌
struct TbkBrandListContentView: View {

    let logger = Logging.Logger(label: "超值大牌")

    var body: some View {
        GenericInfiniteList<ApiDtTbkBrandInfo>(
            column: 1,
            loadingHandler: { firstTime, pageId, loading, noMoreData, dl in
                self.loadingData(firstTime: firstTime, pageId: pageId, loading: loading, noMoreData: noMoreData, dl: dl)
            },
            renderRowHandler: { binding, i, size in
                return self.renderRowHandler(dl: binding, row: i, size: size)
            },
            renderEmptyHandler: {
                return AnyView(Text("-- 获取品牌信息失败 --").font(.largeTitle))
            }
        )
    }

    private func loadingData(
        firstTime: Bool,
        pageId: Binding<Int>,
        loading: Binding<Bool>,
        noMoreData: Binding<Bool>,
        dl: Binding<[ApiDtTbkBrandInfo]>
    ) {
        if (firstTime && dl.wrappedValue.count > 0) {
            return
        }

        let pid = pageId.wrappedValue
        pageId.wrappedValue += 1

        logger.info("fetch page: \(pid)")
        let form = ApiDtTbkBrandListForm(page_id: pid)

        ApiTbkDtkBrandListStub.my_post(args: form) {
            logger.error("fetch \(pid) failed")
            loading.wrappedValue = false
            noMoreData.wrappedValue = true
        } success_cb: { (ret) in
            loading.wrappedValue = false

            guard ret.errno == 0, let data = ret.data else {
                logger.error("获取商品信息失败: \(ret)")
                noMoreData.wrappedValue = true
                return
            }

            dl.wrappedValue += data
        }
    }

    private func renderRowHandler(dl: Binding<[ApiDtTbkBrandInfo]>, row: Int, size: CGSize) -> AnyView {
        let dataList = dl.wrappedValue

        if row >= dataList.count {
            return AnyView(EmptyView())
        }

        let item = dataList[row]

        return AnyView(ScrollView {
            NavigationLink(destination: TbkBrandGoodsListContentView(brandId: item.brand_id)
                .navigationBarTitle(Text(item.brand_name), displayMode: .inline)) {

                HStack {
                    NetworkImageViewV3(url: item.brand_logo, width: size.width / 3)

                    VStack {
                        Text(item.brand_name).font(.title)
                        Text(item.brand_desc ?? "").lineLimit(3)
                    }
                }
            }.buttonStyle(PlainButtonStyle())
        })
    }
}

#if DEBUG
struct TbkBrandListContentView_Previews: PreviewProvider {
    static var previews: some View {
        TbkBrandListContentView()
    }
}
#endif
