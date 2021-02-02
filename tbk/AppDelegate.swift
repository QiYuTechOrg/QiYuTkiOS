import UIKit
import UserNotifications
import Logging


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    private let logger = Logging.Logger(label: "APP")


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        ////////////////////////////////////////////////////////////
        /// 初始化推送处理逻辑
        /// https://lmiller1990.github.io/electic/posts/20191007_notifications_in_swift_5_and_ios_13.html
        ///         // Override point for customization after application launch.
        /// 下面的代码必须在 这里面调用
        UNUserNotificationCenter.current().delegate = self
        ////////////////////////////////////////////////////////////

        // 初始化 一些其他数据
        // 设置设备的 UUID
        if (UserDefaults.standard.string(forKey: AppUserKeys.UUID.rawValue) == nil) {
            let uuid = UUID()
            UserDefaults.standard.set(uuid.uuidString, forKey: "UUID")
        }

        // 检测是否允许 PUSH 通知
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            if (settings.authorizationStatus == .authorized) {
                self.logger.info("push notification is opened")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                return
            }
            self.logger.info("request push notification ...")
            //
            center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if let error = error {
                    self.logger.error("request push notification failed: \(error.localizedDescription)")
                    return
                }
                if granted {
                    self.logger.info("get push notification permission success")
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                } else {
                    self.logger.error("get push notification permission failed")
                    // try goto settings pages
                    // the code is very slow but it works
                    // https://stackoverflow.com/questions/31216856/how-to-open-settings-app-programmatically
                    //
                    // if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    //    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                    // }
                }
            }
        }

        // 初始化 阿里百川 =========================================================
        let bc = AlibcTradeSDK.sharedInstance()
        // bc?.setDebugLogOpen(true)
        bc?.asyncInit(success: {
            self.logger.info("阿里百川: 初始化成功")
        }, failure: { (error) in
            self.logger.critical("\(error.debugDescription)")
        })
        // =========================================================

        // todo this is a const value
        // 微信支付需要注册 【开源代码移除】
        // WXApi.registerApp("", universalLink: "")

        return true
    }


    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        /// upload push device to server
        let pushDeviceParts = deviceToken.map { data in
            String(format: "%02.2hhx", data)
        }
        let pushDevice = pushDeviceParts.joined()
        self.logger.info("iOS PUSH Device Token: \(pushDevice)")

        /// 设置 device token
        AppGlobalSettings.shared.deviceToken = pushDevice
        PushLogic.register()
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        self.logger.error("iOS Push Device Failed to register: \(error)")
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        logger.info("url: \(url), options: \(options)");

        if let alibc = AlibcTradeSDK.sharedInstance() {
            logger.error("run to here");
            if (alibc.application(app, open: url, options: nil) == true) {
                return true
            }
        }

        return true
    }

    // aliBC need this why we need this ???
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        logger.info("ali bc call back is hit url: \(url)")
        if let alibc = AlibcTradeSDK.sharedInstance() {
            if (alibc.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)) {
                return true
            }
        }

        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> ()) {
        self.logger.info("recv notification:")
        self.logger.info("action identifier \(response.actionIdentifier)")
        self.logger.info("recv push content: \(response.notification.request.content.body)")

        // set badge number
        // https://medium.com/better-programming/scheduling-notifications-and-badges-in-swiftui-9edf8574b893
        UIApplication.shared.applicationIconBadgeNumber = 0
        completionHandler()
    }
}

