//
//  LoginViewModel.swift
//  TikTokClone
//
//  Created by Brody on 1/24/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    private let authService: AuthService
    
    init(authService: AuthService){
        self.authService = authService
    }
    
    func login(withEmail email: String, password: String) async {
        do {
            try await authService.login(withEmail: email, password: password)
        }
        catch{
            print("DEBUG Failed to to login in with error \(error.localizedDescription)")
        }
    }
}
