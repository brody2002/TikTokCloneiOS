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
    /// Fetches posts from Firestore
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

        /// Fetches a username from Firestore using a `userId`
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


//
//@Observable
//class MockFeedViewModel: ObservableObject {
//    var posts = [Post]()
//    let videoURLs = [
//        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
//        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
//        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
//        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
//        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
//        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
//        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
//        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
//        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4",
//        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
//        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
//        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4",
//        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4",
//        
//    ]
//    
//    init(){
//        fetchPosts()
//    }
//    
//    func fetchPosts(){
//        self.posts = [
//            .init(
//                id: NSUUID().uuidString,
//                userId: "38sbsefhsefh",
//                videoURL: videoURLs[0],
//                timestamp: "2025-02-10 02:10:23",
//                caption: "That's Arbol",
//                likesAmount: 123,
//                commentsAmount: 33,
//                savesAmount: 1000
//            ),
//            .init(
//                id: NSUUID().uuidString,
//                userId: "awdkawkakwdkawd",
//                videoURL: videoURLs[1],
//                timestamp: "2025-01-11 04:10:4",
//                caption: "REMY BOYS",
//                likesAmount: 10,
//                commentsAmount: 3,
//                savesAmount: 1
//            ),
//            .init(
//                id: NSUUID().uuidString,
//                userId: "sefsehsefhs",
//                videoURL: videoURLs[2],
//                timestamp: "2024-12-03 12:33:10",
//                caption: "TTV clip of the century",
//                likesAmount: 100,
//                commentsAmount: 7,
//                savesAmount: 2
//            )
//            ]
//    }
//                  
//                  
//}
