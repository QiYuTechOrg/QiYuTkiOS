import Foundation
import Logging


/// APP 图片下载辅助工具
class AppImageUtils {

    static var logger = Logger(label: "app_img")

    /// 下载图片辅助函数
    public static func downloadImage(url: URL, failure: @escaping (Error?, URLResponse?) -> Void, success: @escaping (UIImage) -> Void) {
        var url2: URL?
        if (url.description.lowercased().starts(with: "http")) {
            url2 = url
        } else {
            url2 = URL(string: "http:\(url.description)")
        }

        guard let realUrl = url2 else {
            logger.error("not get url")
            return
        }

        guard let cacheImage = MyImageCache.getImage(url: realUrl.description) else {
            URLSession.shared.dataTask(with: realUrl) {
                (data: Data?, response: URLResponse?, error: Error?) -> () in
                guard let realData = data,
                      error == nil,
                      let image = UIImage(data: realData) else {

                    logger.error("dl img failed \(realUrl): \(error as Any) resp: \(response as Any)")

                    DispatchQueue.main.async {
                        failure(error, response)
                    }
                    return
                }

                MyImageCache.putImage(url: realUrl.description, img: image)

                DispatchQueue.main.async {
                    success(image)
                }
            }.resume()
            return
        }

        DispatchQueue.main.async {
            success(cacheImage)
        }
    }

    /// 下载淘宝的头像
    public static func downloadTaoImage(taoId: String, success: @escaping (UIImage) -> Void) {
        if (taoId == "") {
            return
        }

        let urlString = "https://wwc.alicdn.com/avatar/getAvatar.do?userId=\(taoId)&width=160&height=160&type=sns"
        guard let url = URL(string: urlString) else {
            return
        }
        AppImageUtils.downloadImage(url: url, failure: { error, response in
            logger.error("download tao bao image failed")
        }) { image in
            success(image)
        }
    }
}
