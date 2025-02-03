//
//  postService.swift
//  TikTokClone
//
//  Created by Brody on 2/3/25.
//


import Firebase
import FirebaseAuth

/// Deals with all Post Features except Comments
struct PostService {
    
    
    /// Check if user LIKED Post on Firebase Backend
    func checkUserLikedPost(){
        
    }
    func likePost(inputSet: Set<String>, post: Post) async throws {
        // Fetch Post Object
        // Add to the likeAcount
        // Add to the list of Ids of liked users
        
    }
    func dislikePost(){
        
    }

    
    
    // TODO: make new database to store saved Items
    /// Check if user SAVED Post on Firebase Backend
    func checkUserSavedPost(){
        
    }
    func savePost(){
        
    }
    func unsavePost(){
        
    }
    
    // Helpers
    private func fetchPost(postId: String?) async throws -> Post? {
        guard let id = postId else { return nil }
        let fetchedPost = try? await FirestoreConstants.PostCollection.document(id).getDocument(as: Post.self)
        guard let post = fetchedPost else { return nil}
        return fetchedPost
    }
    
}
