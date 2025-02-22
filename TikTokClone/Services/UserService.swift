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
    
    func fetchSpecificUser(userId: String?) async throws -> User? {
        // Obtain user object
        guard let id = userId else { return nil }
        let fetchedUser = try? await FirestoreConstants.UsersCollection.document(id).getDocument(as: User.self)
        guard let fetchedUser  = fetchedUser else { return nil }
        return fetchedUser
    }
    
    func fetchCurrentUser() async throws -> User? {
        guard let currentUid = Auth.auth().currentUser?.uid else { return nil }
        let currentUser = try await FirestoreConstants.UsersCollection.document(currentUid).getDocument(as: User.self)
        return currentUser
    }
    
    /// Uploads user data to fireStorm
    func uploadUserData(_ user: User) async throws {
        do {
            let userData = try Firestore.Encoder().encode(user)
            try await FirestoreConstants.UsersCollection.document(user.id).setData(userData)
        }
        catch { throw error }
    }
    
    func fetchUsers() async throws -> [User] {
        let snapshot = try await FirestoreConstants.UsersCollection.getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self)})
    }
    
    /// Fetching posts from a User's profile
    func fetchPosts(user: User) async throws -> [Post] {
        var posts = [Post]()
        let userSnapshot = try await FirestoreConstants.UsersCollection.document(user.id).getDocument()
        
        guard let userData = userSnapshot.data(),
              let postIds = userData["postIds"] as? [String], !postIds.isEmpty else { return [] }
        
        // Fetch posts where postId is in the retrieved post IDs
        let snapshot = try await FirestoreConstants.PostCollection
            .whereField("postId", in: postIds)
            .getDocuments()
        
        // Decode Firestore documents into Post objects
        posts = snapshot.documents.compactMap { try? $0.data(as: Post.self) }
        return try await withCheckedThrowingContinuation { continuation in
            fetchPostsUsernames(posts: posts) { updatedPosts in
                continuation.resume(returning: updatedPosts)
            }
        }
    }
    
    private func fetchPostsUsernames(posts: [Post], completion: @escaping ([Post]) -> Void) {
        var updatedPosts = posts
        let group = DispatchGroup() // Used to track all async requests
        for (index, post) in posts.enumerated() {
            group.enter() // Track async task
            fetchUsername(for: post.userId) { username in
                DispatchQueue.main.async { updatedPosts[index].username = username }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(updatedPosts)
        }
    }
    
    private func fetchUsername(for userId: String, completion: @escaping (String) -> Void) {
        let unknownName = "unknownName"
        FirestoreConstants.UsersCollection.document(userId).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: Error fetching username: \(error.localizedDescription)")
                completion(unknownName)
                return
            }
            if let data = snapshot?.data(), let username = data["username"] as? String {
                completion(username) }
            else { completion(unknownName) }
        }
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
