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
                        print("⚠️ Failed to fetch posts: \(error.localizedDescription)")
                        return
                    }
                    guard let documents = snapshot?.documents else {
                        print("⚠️ No documents found.")
                        return
                    }
                    DispatchQueue.main.async {
                        self.posts = documents.compactMap { try? $0.data(as: Post.self) }
                        print("📜 Decoded Posts:", self.posts)
                        
                        // Username Fetch func
                        self.fetchPostsUsernames()
                    }
                }
        }
        private func fetchPostsUsernames() {
            var updatedPosts = self.posts
            let group = DispatchGroup() // Used to track all async requests
            
            for (index, post) in self.posts.enumerated() {
                group.enter() // Track async task
                fetchUsername(for: post.userId) { username in
                    DispatchQueue.main.async { updatedPosts[index].username = username }
                    group.leave() // Mark task as complete
                }
            }
            
            group.notify(queue: .main) {
                // Update state only once after all usernames are fetched
                self.posts = updatedPosts
                print("✅ Updated posts with usernames:", self.posts)
            }
        }

        private func fetchUsername(for userId: String, completion: @escaping (String) -> Void) {
            let unknownName = "unknownName"
            FirestoreConstants.UsersCollection.document(userId).getDocument { snapshot, error in
                if let error = error {
                    print("⚠️ Error fetching username: \(error.localizedDescription)")
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
