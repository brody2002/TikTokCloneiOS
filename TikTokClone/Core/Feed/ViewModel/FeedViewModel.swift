//
//  FeedViewModel.swift
//  TikTokClone
//
//  Created by Brody on 1/22/25.
//

import Foundation
import FirebaseFirestore



@Observable
class FeedViewModel: ObservableObject {
    var posts = [Post]()
    init() {
        fetchPosts()
    }
    
    /// Fetches all TikTok posts available from Firestore
    func fetchPosts() {
        FirestoreConstants.PostCollection
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("DEBUG: Failed to fetch posts: \(error.localizedDescription)")
                    return
                }
                guard let documents = snapshot?.documents else {
                    print("DEBUG: No documents found.")
                    return
                }
                DispatchQueue.main.async {
                    self.posts = documents.compactMap { try? $0.data(as: Post.self) }
                    self.fetchPostsUsernames()
                }
            }
    }
    
    private func fetchPostsUsernames() {
        var updatedPosts = self.posts
        // Used to track all async requests
        let group = DispatchGroup()
        for (index, post) in self.posts.enumerated() {
            group.enter() // Track async task
            fetchUsername(for: post.userId) { username in
                DispatchQueue.main.async { updatedPosts[index].username = username }
                group.leave() // Mark task as complete
            }
        }
        // Update state only once after all usernames are fetched
        group.notify(queue: .main) {
            self.posts = updatedPosts
        }
    }
    
    private func fetchUsername(for userId: String, completion: @escaping (String) -> Void) {
        let unknownName = "unknownName"
        FirestoreConstants.UsersCollection.document(userId).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: ⚠️ Error fetching username: \(error.localizedDescription)")
                completion(unknownName)
                return
            }
            if let data = snapshot?.data(), let username = data["username"] as? String {
                completion(username)
            } else {
                completion(unknownName)
            }
        }
    }
}
