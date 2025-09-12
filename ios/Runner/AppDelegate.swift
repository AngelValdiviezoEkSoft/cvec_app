/*
import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
*/
//////////////

import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let callChannel = "call_channel"
    private let emailChannel = "email_channel"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        
        // Canal para llamadas
        let callMethodChannel = FlutterMethodChannel(name: callChannel, binaryMessenger: controller.binaryMessenger)
        callMethodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "makePhoneCall" {
                if let args = call.arguments as? [String: Any],
                   let phoneNumber = args["phone"] as? String,
                   let url = URL(string: "tel://\(phoneNumber)") {
                    
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        result(nil)
                    } else {
                        result(FlutterError(code: "UNAVAILABLE", message: "No se pudo abrir la aplicación de teléfono", details: nil))
                    }
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Número de teléfono no válido", details: nil))
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        // Canal para emails
        let emailMethodChannel = FlutterMethodChannel(name: emailChannel, binaryMessenger: controller.binaryMessenger)
        emailMethodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "openEmailApp" {
                if let args = call.arguments as? [String: Any],
                   let email = args["email"] as? String,
                   let url = URL(string: "mailto:\(email)") {
                    
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        result(nil)
                    } else {
                        result(FlutterError(code: "UNAVAILABLE", message: "No se pudo abrir la aplicación de correo", details: nil))
                    }
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Correo no válido", details: nil))
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

