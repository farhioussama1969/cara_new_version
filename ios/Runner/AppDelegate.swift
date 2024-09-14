import Flutter
import UIKit
import Firebase
import FirebaseMessaging
import flutter_local_notifications
import GoogleMaps
import flutter_config

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

                FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
                              GeneratedPluginRegistrant.register(with: registry)
                          }

          if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
          }
          FirebaseApp.configure()
          GMSServices.provideAPIKey(FlutterConfigPlugin.env(for: "GOOGLE_MAPS_API_KEY"))


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


     override func application(_ application: UIApplication,
                didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

                 Messaging.messaging().apnsToken = deviceToken
                 print("Token: \(deviceToken)")
                 super.application(application,
                 didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
               }
}
