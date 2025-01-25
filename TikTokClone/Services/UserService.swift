//
//  UserService.swift
//  TikTokClone
//
//  Created by Brody on 1/24/25.
//

import FirebaseAuth
import FirebaseFirestore

struct UserService {
    
    // Uploads user data to fireStorm/
    func uploadUserData(_ user: User) async throws {
        do {
            let userData = try Firestore.Encoder().encode(user)
            try await Firestore.firestore(database: "database").collection("users").document(user.id).setData(userData)
        }
        catch {
            throw error
        }
    }
    
}
