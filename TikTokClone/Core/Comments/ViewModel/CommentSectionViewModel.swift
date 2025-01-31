//
//  CommentSectionViewModel.swift
//  TikTokClone
//
//  Created by Brody on 1/31/25.
//

import Foundation
import Firebase
import FirebaseFirestore


class CommentSectionViewModel: ObservableObject {
    let userService: UserService
    let post: Post
    
    init(post: Post){
        self.userService = UserService()
        self.post = post
    }
    
    // Upload Comment to Firebase
    // 1. Create Comment Object
    // 2. Add Comment Object to a dedicated CommentsSection
    // 3. Upload both Objects to firebase
    func uploadCommentToFirebase(message: String) async throws {
        guard !message.isEmpty else { return }
        guard let userObject = try? await userService.fetchCurrentUser() else { return }
        
        let commentId = NSUUID().uuidString
        let comment: [String: Any] = [
            "id": commentId,
            "username": userObject.username,
            "usernameId": userObject.id,
            "message": message,
            "timestamp": Timestamp.formatDate(),
            "likes": 0,
            "thumbsDown": 0,
            "replyList": [Comment](),
            "replyAmount": 0
        ]
        
        // Add Comment to the Comments database
        try await FirestoreConstants.CommentsCollection.document(commentId).setData(comment)
        
        // Upload Comment to CommentSection database that stores all comments for a singular post
        try await FirestoreConstants.CommentSectionCollections.document(post.id).updateData([
            "commentIds": FieldValue.arrayUnion([commentId]),
            "commentAmount": FieldValue.increment(Int64(1)) // increment number by 1
        ])
    }
    
    func deleteCommentToFirebase(){
        
    }
    
    // Fetch Comments on post
    func fetchCommentsOnPost(postId: String) async -> [Comment] {
        return []
    }
}
