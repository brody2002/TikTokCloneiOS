//
//  TikTokCloneApp.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck

// Get's called when app is finishes launching
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
class MyAppCheckProvider: NSObject, AppCheckProviderFactory {
    func createProvider(with app: FirebaseApp) -> (any AppCheckProvider)? {
        return AppAttestProvider(app: app)
    }
}

@main
struct TikTokCloneApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private let authService = AuthService()
    private let userService = UserService()
    init(){
        AppCheck.setAppCheckProviderFactory(MyAppCheckProvider())
    }
    var body: some Scene {
        WindowGroup {
            ContentView(authService: authService, userService: userService)
        }
    }
}
