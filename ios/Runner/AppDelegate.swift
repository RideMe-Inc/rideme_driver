import Flutter
import UIKit
import GoogleMaps
import flutter_background_service_ios



@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    GMSServices.provideAPIKey("AIzaSyAIO-3vFI_0dmGTdOv9oojSnbXNysdXxmQ")

    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "background_services"


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
