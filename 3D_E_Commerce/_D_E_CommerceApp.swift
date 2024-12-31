//
//  _D_E_CommerceApp.swift
//  3D_E_Commerce
//
//  Created by Lathif A.D on 13/09/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct _D_E_CommerceApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(OrderViewModel())
                .environmentObject(BaseViewModel())
                .environmentObject(CartViewModel())
        }
    }
}
