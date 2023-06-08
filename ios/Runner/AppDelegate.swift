import UIKit
import Flutter
import GoogleMaps  // Add this import for GoogleMaps Application

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
        // TODO: Add your Google Maps API key
        GMSServices.provideAPIKey("AIzaSyDeaORg0N-qwnLpfbspQ5XgTlu1pfP1ARc")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
