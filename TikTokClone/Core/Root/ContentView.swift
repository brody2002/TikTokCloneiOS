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
    
    init(authService: AuthService){
        self.authService = authService
        
        //self._ when init @StateObject
        let vm = ContentViewModel(authService: authService)
        self._viewModel = StateObject(wrappedValue: vm)
    }
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                // If some is logged in
                MainTabView(authService: authService)
            } else {
                // if someone isn't logged in
                LoginView(authService: authService)
            }
        }
    }
}

#Preview {
    ContentView(authService: AuthService())
}
