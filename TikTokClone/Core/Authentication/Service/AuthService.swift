//
//  AuthService.swift
//  TikTokClone
//
//  Created by Brody on 1/24/25.
//

import Firebase
import FirebaseAuth

@MainActor
class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    private let userService: UserService = UserService()
    
    func updateUserSession(){
        // if there is a current user logged into fire base
        // this value will have a user id -> uid
        // Note: this could return nil meaning there is no logged in user
        self.userSession = Auth.auth().currentUser
    }
    
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            print("DEGBUG: User is \(result.user.uid)")
        }
        catch{
            print("DEBUG: Failed to Login user with error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func createUser(
        withEmail email: String,
        password: String,
        username: String,
        fullName: String
    ) async throws {
        print("DEBUG: User info \(email) \(username) \(fullName)")
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(id: result.user.uid, withEmail: email, username: username, fullName: fullName)
        }
        catch{
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
            throw error
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut() // signs out user out of firebase backend
        self.userSession = nil // updates routing logic by wiping user session
    }
    
    private func uploadUserData(
        id: String,
        withEmail email: String,
        username: String,
        fullName: String
    ) async throws {
        let user = User(id: id, username: username, email: email, fullName: fullName)
        try await userService.uploadUserData(user)
    }
}
