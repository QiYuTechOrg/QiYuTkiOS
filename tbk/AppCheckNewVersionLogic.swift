import Foundation

/// APP 升级检测逻辑
class AppCheckNewVersionLogic {
    /// 检测是否有新版本
    /// true  有新版
    /// false 没有
    /// nil   检测失败
    /// - Returns:
    public static func haveNewVersion() -> Bool? {
        guard let info = Bundle.main.infoDictionary,
              let currentVersion = info["CFBundleShortVersionString"] as? String,
              let identifier = info["CFBundleIdentifier"] as? String,
              let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(identifier)") else {
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
                return nil
            }

            if let result = (json["results"] as? [Any])?.first as? [String: Any],
               let version = result["version"] as? String {
                return version != currentVersion
            }

            return nil
        } catch _ as NSError {
            return nil
        }
    }
}
