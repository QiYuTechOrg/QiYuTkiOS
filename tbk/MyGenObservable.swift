import Foundation
import SwiftUI
import Logging
import Combine

/// 热搜记录
class HotWordsDataObserved: ObservableObject {

    var logger = Logging.Logger(label: "热搜记录")

    @Published var hotWords: [String] = []

    private var isLoaded = false

    public static let shared = HotWordsDataObserved()

    init() {
        self.loadData()
    }

    private func loadData() {
        objc_sync_enter(self)
        if (self.isLoaded) {
            objc_sync_exit(self)
            return
        }

        self.isLoaded = true
        objc_sync_exit(self)

        self.logger[metadataKey: "type"] = "热搜记录"

        ApiZtkKeywordStub.my_get(failure_cb: {}) { model in

            guard model.errno == 0, let data = model.data else {
                self.logger.error("错误码: \(model.errno), 错误信息: \(model.errmsg)")
                return
            }

            self.logger.info("load data: \(data)")

            /////////////////////////////////////////////////////
            /// How to solve
            /// 这个问题已经解决
            /// 在回调的时候 使用
            ///
            /// ```swfit
            /// DispatchQueue.main.async {
            ///     // the code
            /// }
            /// ```
            ///
            /////////////////////////////////////////////////
            /// "Publishing changes from background threads is not allowed;
            /// make sure to publish values from the main thread
            /// (via operators like receive(on:))
            /// on model updates."
            /////////////////////////////////////////////////
            ///  error?
            /////////////////////////////////////////////////////
            ///
            /// https://developer.apple.com/forums/thread/128119
            ///
            self.hotWords.append(contentsOf: data)
        }
    }
}


struct QueryAns: Identifiable, Hashable {
    let id = UUID()
    let q: String
    let a: String
}

enum QuestionQueryErrorEnum: Identifiable {
    case network  // 网络错误
    case server   // 服务器错误
    case noData   // 没有数据
    case notLogin // 没有登陆

    var id: Int {
        self.hashValue
    }
}

/// 内容查询
class QuestionQueryObserved: ObservableObject {
    var logger = Logging.Logger(label: "查询")

    @Published var errorState: QuestionQueryErrorEnum? = nil

    @Published var serverMsg = ""

    @Published var ans: [QueryAns] = []

    @Published var isQuerying = false

    /// global unique (in case of not use same variable, can not recv signal)
    static var shared = QuestionQueryObserved()

    func doQuery(q: String) {
        let token = AppUserSettings.shared.token
        if (token == "") {
            logger.error("user is not login")
            self.errorState = .notLogin
            return
        }

        self.isQuerying = false
    }
}
