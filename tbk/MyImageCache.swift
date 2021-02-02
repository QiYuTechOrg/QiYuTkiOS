import Foundation
import Logging
import Cache
import CryptoKit


/// 我的图片缓存
class MyImageCache {
    private static var storage: DiskStorage<String, UIImage>? = nil
    private static var logger = Logging.Logger(label: "图片缓存")

    // 设置 图片
    public static func putImage(url: String, img: UIImage) {
        guard let storage = getStorage() else {
            return
        }
        let key = MyImageCache.getUrlKey(url: url)
        try? storage.setObject(img, forKey: key)
    }

    /// 读取图片
    public static func getImage(url: String) -> UIImage? {
        guard let storage = getStorage() else {
            return nil
        }
        let key = MyImageCache.getUrlKey(url: url)
        guard let entry = try? storage.entry(forKey: key) else {
            logger.info("获取缓存图片失败: \(url)")
            return nil
        }
        return entry.object
    }

    private static func getStorage() -> DiskStorage<String, UIImage>? {
        guard let storage = MyImageCache.storage else {
            let diskConfig = DiskConfig(name: "ImgCache")
            MyImageCache.storage = try? DiskStorage(config: diskConfig, transformer: TransformerFactory.forImage())
            return MyImageCache.storage
        }
        return storage
    }

    // 获取 URL key
    private static func getUrlKey(url: String) -> String {
        let digest = SHA256.hash(data: url.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
