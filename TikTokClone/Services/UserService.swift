//
//  UserService.swift
//  TikTokClone
//
//  Created by Brody on 1/24/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol UserServiceProtocol{
    func fetchUsers() async throws -> [User]
    func fetchPosts(user: User) async throws -> [Post]
}

struct UserService: UserServiceProtocol {
    
    func fetchCurrentUser() async throws -> User? {
        guard let currentUid = Auth.auth().currentUser?.uid else { return nil }
        let currentUser = try await FirestoreConstants.UsersCollection.document(currentUid).getDocument(as: User.self)
        print("DEBUG: Current user is \(currentUser)")
        return currentUser
    }
    
    /// Uploads user data to fireStorm
    func uploadUserData(_ user: User) async throws {
        do {
            let userData = try Firestore.Encoder().encode(user)
            try await FirestoreConstants.UsersCollection.document(user.id).setData(userData)
        }
        catch {
            throw error
        }
    }
    
    func fetchUsers() async throws -> [User] {
        let snapshot = try await FirestoreConstants.UsersCollection.getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
    }
    
    func fetchPosts(user: User) async throws -> [Post] {
        // Step 1: Fetch user's document from Firestore
        let userSnapshot = try await FirestoreConstants.UsersCollection.document(user.id).getDocument()
        
        // Step 2: Extract post IDs from user data
        guard let userData = userSnapshot.data(),
              let postIds = userData["postIds"] as? [String], !postIds.isEmpty else {
            print("No posts found for user.")
            return []
        }
        // Step 3: Fetch posts where postId is in the retrieved post IDs
        let snapshot = try await FirestoreConstants.PostCollection
            .whereField("postId", in: postIds)
            .getDocuments()

        // Step 4: Decode Firestore documents into Post objects
        let posts = snapshot.documents.compactMap { try? $0.data(as: Post.self) }
        
        return posts
    }

    
}

struct MockUserService: UserServiceProtocol {
    func fetchUsers() async throws -> [User] {
        return DeveloperPreview.users
    }
    func fetchPosts(user: User) async throws -> [Post]{
        return [DeveloperPreview.post]
    }
}
