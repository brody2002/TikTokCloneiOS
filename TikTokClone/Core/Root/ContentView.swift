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
                if let user = viewModel.currentUser {
                    @StateObject var currentUser = CurrentUser(
                        id: user.id,
                        username: user.username,
                        email: user.email,
                        fullName: user.fullName,
                        bio: user.bio,
                        profileImageUrl: user.profileImageUrl
                    )
                    MainTabView(authService: authService, user: user, currentUser: currentUser)
                }
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
