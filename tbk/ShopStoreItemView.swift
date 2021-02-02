import SwiftUI
import Foundation
import Combine
import Logging


/// 加载网络图片优化 第二版
class NetworkImageV2: ObservableObject {
    var logger = Logging.Logger(label: "网络图片V2")

    var slot: Image = Image("item_slot")

    @Published var img: Image? = nil

    init(url: URL?, slot: Image? = nil) {
        if let s = slot {
            self.slot = s
        }

        guard let u = url else {
            self.logger.info("invalid URL")
            return
        }

        let key: String
        if u.description.starts(with: "http") {
            key = u.description
        } else {
            key = "http:\(u.description)"
        }

        guard let uiImage = MyImageCache.getImage(url: key) else {
            AppImageUtils.downloadImage(url: u, failure: { err, resp in
                self.logger.error("下载图片失败: url=\(key) err=\(err.debugDescription) resp=\(resp.debugDescription)")
            }) { img in
                self.img = Image(uiImage: img)
            }
            return
        }

        self.img = Image(uiImage: uiImage)
    }
}


enum NetworkImageOp {
    case none
    case fit
    case fill
}

// 优化版本的网络图片加载器
struct NetworkImageViewV3: View {
    var width: CGFloat

    @ObservedObject var networkImage: NetworkImageV2

    var op: NetworkImageOp

    init(url: String, width: CGFloat, op: NetworkImageOp = .none) {
        self.width = width
        self.networkImage = NetworkImageV2(url: URL(string: url))
        self.op = op
    }

    var body: some View {
        switch op {
        case .none:
            getImage().resizable().frame(width: width, height: width)
        case .fill:
            getImage().resizable().scaledToFill().frame(width: width, height: width)
        case .fit:
            getImage().resizable().scaledToFit().frame(width: width, height: width)
        }
    }

    func getImage() -> Image {
        if let img = networkImage.img {
            return img
        } else {
            return self.networkImage.slot
        }
    }
}


