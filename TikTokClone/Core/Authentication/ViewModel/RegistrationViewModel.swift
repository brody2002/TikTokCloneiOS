//
//  RegistrationViewModel.swift
//  TikTokClone
//
//  Created by Brody on 1/24/25.
//

import Foundation


class RegistrationViewModel: ObservableObject {
    
    private let authService: AuthService
    
    init(authService: AuthService){
        self.authService = authService
    }
    
    func createUser(withEmail email: String, password: String, fullName: String, username: String) async {
        do {
            try await authService
                .createUser(
                    withEmail: email,
                    password: password,
                    username: username,
                    fullName: fullName
                )
        }
        catch{
            print("DEBUG Failed to register in with error \(error.localizedDescription)")
        }
    }
}
