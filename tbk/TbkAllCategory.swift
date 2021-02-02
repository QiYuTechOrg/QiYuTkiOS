import SwiftUI

import Logging


struct TbkScItemView: View {

    let item: ApiDtCategoryGetSuperCategoryRespSubcategories

    let size: CGSize

    init(item: ApiDtCategoryGetSuperCategoryRespSubcategories, size: CGSize) {
        self.item = item
        self.size = size
    }

    var body: some View {
        getView()
    }

    func getView() -> AnyView {

        guard let name = item.subcname, let subCid = item.subcid else {
            return AnyView(VStack {
                EmptyView()
            })
        }

        return AnyView(
            NavigationLink(
                destination: TbkSubCategoryContentView(subCid: subCid.description)
                    .navigationBarTitle(Text(name), displayMode: .inline)) {

                VStack {
                    NetworkImageViewV3(url: item.scpic ?? "", width: self.size.width / 3, op: .fill)
                        .cornerRadius(self.size.width / 3 / 2)

                    Text(name).font(.system(size: 12))
                }
            }.buttonStyle(PlainButtonStyle()))
    }
}


struct TbkSubCategoryView: View {
    let data: ApiDtCategoryGetSuperCategoryResp
    let rows: Int
    let proxy: GeometryProxy

    init(data: ApiDtCategoryGetSuperCategoryResp, proxy: GeometryProxy) {
        self.data = data
        self.rows = ((data.subcategories?.count ?? 0) + 1) / 3
        self.proxy = proxy
    }

    var body: some View {
        List {
            ForEach(0..<rows) { row in
                renderHStack(row: row)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
        }
    }

    func renderHStack(row: Int) -> AnyView {
        let sp: CGFloat = 8

        let size = CGSize(width: proxy.size.width - 20 - (4 * sp), height: proxy.size.height)

        return AnyView(ScrollView {
            HStack(spacing: sp) {
                Spacer()
                renderItem(row: row, column: 0, size: size)
                renderItem(row: row, column: 1, size: size)
                renderItem(row: row, column: 2, size: size)
                Spacer()
            }
        })
    }

    func renderItem(row: Int, column: Int, size: CGSize) -> AnyView {
        if (row * 3 + column) >= (data.subcategories?.count ?? 0) {
            return AnyView(EmptyView())
        }

        guard let d = data.subcategories?[row * 3 + column] else {
            return AnyView(EmptyView())
        }


        return AnyView(TbkScItemView(item: d, size: size))
    }
}

struct TbkAllCategoriesView: View {
    @Environment(\.colorScheme) var colorScheme

    let category: [ApiDtCategoryGetSuperCategoryResp]
    let rows: Int

    @State var selectRow: Int = 0

    init(category: [ApiDtCategoryGetSuperCategoryResp]) {
        self.category = category
        self.rows = category.count
    }

    var body: some View {
        GeometryReader { reader in
            HStack {
                List {
                    ForEach(0..<rows, id: \.self) { row in
                        getNavView(row: row)
                    }
                }.frame(width: reader.size.width / 3.33)

                GeometryReader { r2 in
                    TbkSubCategoryView(data: self.category[selectRow], proxy: r2)
                }
            }
        }
    }

    func getNavView(row: Int) -> AnyView {
        guard let name = self.category[row].cname else {
            return AnyView(EmptyView())
        }

        return AnyView(
            Text(name)
                .frame(maxWidth: .infinity)
                .foregroundColor(getColor(row: row))
                .onTapGesture {
                    selectRow = row
                })
    }

    func getColor(row: Int) -> Color {
        if (row == selectRow) {
            return .red
        }
        // 兼容黑暗模式
        if (colorScheme == .dark) {
            return .white
        } else {
            return .black
        }
    }
}


// 超级分类
struct TbkAllCategory: View {

    let logger = Logging.Logger(label: "超级分类")

    @State var loading = true

    @State var category: [ApiDtCategoryGetSuperCategoryResp] = []


    var body: some View {
        if (loading) {
            MyActivityIndicator().onAppear {
                self.onAppearLoadingData()
            }
        } else {
            TbkAllCategoriesView(category: category)
        }
    }

    private func onAppearLoadingData() {
        ApiDtkSuperCategoryStub.my_get(failure_cb: {
            loading = false
            logger.error("加载分类信息失败")
        }) { ret in

            loading = false
            guard ret.errno == 0, let data = ret.data else {
                logger.error("加载分类失败: \(ret.errmsg)")
                return
            }

            guard data.count != 0 else {
                logger.error("没有获取到分类信息")
                return
            }

            logger.info("获取分类信息成功")
            category = data
        }
    }
}

#if DEBUG
struct TbkAllCategory_Previews: PreviewProvider {
    static var previews: some View {
        TbkAllCategory()
    }
}
#endif
