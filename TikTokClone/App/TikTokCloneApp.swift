//
//  TikTokCloneApp.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI
import FirebaseCore

// Get's called when app is finishes launching
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct TikTokCloneApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private let authService = AuthService()
    
    var body: some Scene {
        WindowGroup {
            ContentView(authService: authService)
        }
    }
}
