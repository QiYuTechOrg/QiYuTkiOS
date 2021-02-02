import Foundation
import SwiftUI


struct GenericItemListView<ItemType>: View {
    // 当前的数据
    var dataList: Binding<[ItemType]>

    // 加载数据中
    var loadingState: Binding<Bool>

    // 没有更多数据
    var noMoreData: Binding<Bool>

    // 当前获取到了多少页
    var pageId: Binding<Int>

    // 一共有多少行
    var rows: Int

    var rowInsets: EdgeInsets

    var loadingHandler: (_ firstTime: Bool, _ pageId: Binding<Int>, _ loading: Binding<Bool>, _ noMoreData: Binding<Bool>, _ dl: Binding<[ItemType]>) -> Void

    var renderRowHandler: (_ dl: Binding<[ItemType]>, _ row: Int, _ size: CGSize) -> AnyView

    var renderEmptyHandler: Optional<() -> AnyView>

    @State private var showPullToRefresh: Bool = false

    init(dl: Binding<[ItemType]>,
         page: Binding<Int>,
         loading: Binding<Bool>,
         noMoreData: Binding<Bool>,
         column: Int,
         rowInsets: EdgeInsets,
         loadingHandler: @escaping (_ firstTime: Bool, _ pageId: Binding<Int>, _ loading: Binding<Bool>, _ noMoreData: Binding<Bool>, _ dl: Binding<[ItemType]>) -> Void,
         renderRowHandler: @escaping (_ dl: Binding<[ItemType]>, _ row: Int, _ size: CGSize) -> AnyView,
         renderEmptyHandler: Optional<() -> AnyView> = nil
    ) {
        self.dataList = dl
        self.loadingState = loading
        if (column == 1) {
            self.rows = dl.wrappedValue.count
        } else {
            self.rows = (dl.wrappedValue.count + 1) / 2
        }
        self.noMoreData = noMoreData
        self.rowInsets = rowInsets
        self.pageId = page

        self.loadingHandler = loadingHandler
        self.renderRowHandler = renderRowHandler
        self.renderEmptyHandler = renderEmptyHandler

        // https://stackoverflow.com/questions/56553672/how-to-remove-the-line-separators-from-a-list-in-swiftui-without-using-foreach
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().separatorColor = .clear
        ///////////////////////////////////////////////////////////////////////////////////////////////////

        // https://stackoverflow.com/questions/58320037/is-there-a-way-to-hide-scroll-indicators-in-a-swiftui-list
        UITableView.appearance().showsVerticalScrollIndicator = false
    }

    var body: some View {

        // 删除 List 左右的空格
        // https://stackoverflow.com/questions/56614080/how-to-remove-the-left-and-right-padding-of-a-list-in-swiftui
        GeometryReader { reader in
            if (rows == 0 && loadingState.wrappedValue == false && self.renderEmptyHandler != nil) {
                self.renderEmptyHandler!()
            } else {
                List {
                    ForEach(0..<rows, id: \.self) { row in
                        if (row + 1 == rows) {
                            renderRowHandler(dataList, row, reader.size)
                                .listRowInsets(self.rowInsets)
                                .onAppear {
                                    if (self.noMoreData.wrappedValue == false) {
                                        self.loadingHandler(false, self.pageId, self.loadingState, self.noMoreData, self.dataList)
                                    }
                                }
                        } else {
                            renderRowHandler(dataList, row, reader.size)
                                .listRowInsets(self.rowInsets)
                        }
                    }
                }
                    .pullToRefresh(isShowing: $showPullToRefresh) {
                        self.showPullToRefresh = false
                        self.noMoreData.wrappedValue = false
                        self.loadingState.wrappedValue = true
                        self.dataList.wrappedValue = []
                        self.pageId.wrappedValue = 1
                        self.loadingHandler(true, self.pageId, self.loadingState, self.noMoreData, self.dataList)
                    }
            }
        }
            .onAppear {
                self.pageId.wrappedValue = 1
                self.loadingHandler(true, self.pageId, self.loadingState, self.noMoreData, self.dataList)
            }

    }
}


/// v2 version for infinite list
/// 这是测试版,当前并没有使用
struct GenericInfiniteV2List<ItemType, ParamType, RetType>: View {
    @State var dataList: [ItemType] = []
    @State var pageId: Int = 1
    // 加载状态 [是否正在加载中 ]
    @State var loadingState: Bool = true
    // 没有更多数据 [设置为 true, 停止加载更多的数据]
    @State var noMoreData = false

    var rowInsets = EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)

    var column: Int

    var getParamHandler: (_ pageId: Int) -> ParamType
    var fetchDataHandler: (_ param: ParamType, _ failure_cb: () -> Void, _ success_cb: (RetType) -> Void) -> Void
    var fetchDataSuccessCb: (RetType) -> Void
    var fetchDataFailureCb: Optional<() -> Void> = nil

    var renderRowHandler: (_ dl: Binding<[ItemType]>, _ row: Int, _ size: CGSize) -> AnyView
    var renderEmptyHandler: Optional<() -> AnyView> = nil

    var body: some View {
        VStack {
            if (loadingState) {
                MyActivityIndicator()
            } else {
                EmptyView()
            }

            GenericItemListView(
                dl: self.$dataList,
                page: self.$pageId,
                loading: self.$loadingState,
                noMoreData: self.$noMoreData,
                column: self.column,
                rowInsets: rowInsets,
                loadingHandler: self.loadingData,
                renderRowHandler: self.renderRowHandler,
                renderEmptyHandler: self.renderEmptyHandler)
        }
    }

    func loadingData(
        firstTime: Bool,
        pageId: Binding<Int>,
        loading: Binding<Bool>,
        noMoreData: Binding<Bool>,
        dl: Binding<[ItemType]>
    ) {
        if firstTime && dl.wrappedValue.count > 0 {
            return
        }
        let pid = pageId.wrappedValue
        pageId.wrappedValue += 1
        let args = getParamHandler(pid)

        let defaultFailureCb = {
            loading.wrappedValue = false
            noMoreData.wrappedValue = true
        }
        self.fetchDataHandler(args, self.fetchDataFailureCb ?? defaultFailureCb, self.fetchDataSuccessCb)
    }
}

/// 通用的无限列表 :)
struct GenericInfiniteList<ItemType>: View {

    @State var dataList: [ItemType] = []
    @State var pageId: Int = 1
    // 加载状态 [是否正在加载中 ]
    @State var loadingState: Bool = true
    // 没有更多数据 [设置为 true, 停止加载更多的数据]
    @State var noMoreData = false

    var rowInsets = EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)

    var column: Int
    var loadingHandler: (_ firstTime: Bool,
                         _ pageId: Binding<Int>,
                         _ loading: Binding<Bool>,
                         _ noMoreData: Binding<Bool>,
                         _ dl: Binding<[ItemType]>) -> Void

    var renderRowHandler: (_ dl: Binding<[ItemType]>, _ row: Int, _ size: CGSize) -> AnyView
    var renderEmptyHandler: Optional<() -> AnyView> = nil

    var body: some View {
        VStack {
            if (loadingState) {
                MyActivityIndicator()
            } else {
                EmptyView()
            }

            GenericItemListView(
                dl: self.$dataList,
                page: self.$pageId,
                loading: self.$loadingState,
                noMoreData: self.$noMoreData,
                column: self.column,
                rowInsets: rowInsets,
                loadingHandler: self.loadingHandler,
                renderRowHandler: self.renderRowHandler,
                renderEmptyHandler: self.renderEmptyHandler)
        }
    }
}
