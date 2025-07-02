import Flutter
import UIKit
import GoogleMaps
import flutter_background_service_ios
import PushKit
import flutter_callkit_incoming
import FirebaseCore
import FirebaseMessaging



@main
@objc class AppDelegate: FlutterAppDelegate, PKPushRegistryDelegate {
    func pushRegistry(_ registry: PKPushRegistry, didUpdate pushCredentials: PKPushCredentials, for type: PKPushType) {
        
    }

    func pushRegistry(_ registry: PKPushRegistry, didReceiveIncomingPushWith payload: PKPushPayload, for type: PKPushType, completion: @escaping () -> Void) {
            print("didReceiveIncomingPushWith")
            guard type == .voIP else { return }
            
            let id = payload.dictionaryPayload["id"] as? String ?? ""
            let nameCaller = payload.dictionaryPayload["nameCaller"] as? String ?? ""
            let handle = payload.dictionaryPayload["handle"] as? String ?? ""
            let isVideo = payload.dictionaryPayload["isVideo"] as? Bool ?? false
            
            let data = flutter_callkit_incoming.Data(id: id, nameCaller: nameCaller, handle: handle, type: isVideo ? 1 : 0)
        
            SwiftFlutterCallkitIncomingPlugin.sharedInstance?.showCallkitIncoming(data, fromPushKit: true)
            
            //Make sure call completion()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                completion()
            }
        }
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Foundation.Data) {
        
        Messaging.messaging().apnsToken = deviceToken
        
        super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        
    }
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("'")

    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "background_services"

      
    FirebaseApp.configure()
      
      
    application.registerForRemoteNotifications()
    GeneratedPluginRegistrant.register(with: self)

      let mainQueue = DispatchQueue.main
      let voipRegistry = PKPushRegistry(queue: mainQueue)
      voipRegistry.delegate = self
      voipRegistry.desiredPushTypes = [PKPushType.voIP]

      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    

}



// @main
// @objc class AppDelegate: FlutterAppDelegate {

//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {

//     GMSServices.provideAPIKey("'")

//     SwiftFlutterBackgroundServicePlugin.taskIdentifier = "background_services"


//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }
