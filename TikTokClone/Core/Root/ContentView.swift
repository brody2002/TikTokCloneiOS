//
//  ContentView.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel
    private let authService: AuthService
    private let userService: UserService
    
    init(authService: AuthService, userService: UserService){
        self.authService = authService
        self.userService = userService
        
        //self._ when init @StateObject
        let vm = ContentViewModel(authService: authService, userService: userService)
        self._viewModel = StateObject(wrappedValue: vm)
    }
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                if let user = viewModel.currentUser { MainTabView(authService: authService, user: user) }
            } else {
                // if someone isn't logged in
                LoginView(authService: authService)
            }
        }
    }
}

#Preview {
    ContentView(authService: AuthService(), userService: UserService())
}
