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
    
    func uploadCommentToFirebase(message: String) async throws {
        // Upload Comment to Firebase
        // 1. Create Comment Object
        // 2. Add Comment Object to a dedicated CommentsSection
        // 3. Upload both Objects to firebase
        guard !message.isEmpty else { return }
        guard let userObject = try? await userService.fetchCurrentUser() else { return }
        
        let commentId = NSUUID().uuidString
        let comment: [String: Any] = [
            "commentId": commentId,
            "postId": post.id,
            "username": userObject.username,
            "id": userObject.id,
            "message": message,
            "timestamp": Timestamp.formatDate(),
            "likes": 0,
            "thumbsDown": 0,
            "replyList": [Comment](),
            "replyAmount": 0
        ]
        
        // Add Comment to the Comments database
        try await FirestoreConstants.CommentsCollection.document(commentId).setData(comment)
        
                
        do {
            // Upload Comment to CommentSection database that stores all comments for a singular post
            try await FirestoreConstants.CommentSectionCollections.document(post.id).updateData([
                "commentIds": FieldValue.arrayUnion([commentId]),
                "commentAmount": FieldValue.increment(Int64(1)) // increment number by 1
            ])
        }
        catch { print("DEBUG: Error uploading CommentSection database")}
    }
    
    func deleteCommentToFirebase(){
        
    }
    
    //HAS ISSUES somewhere
    func fetchCommentsOnPost(postId: String) async throws -> [Comment] {
        /// returns Array of Comment Objects
        let commentSectionDocument = FirestoreConstants.CommentSectionCollections.document(postId)
        let commentIds = try await commentSectionDocument.getDocument(as: [String].self)
        var comments: [Comment] = []
        for commentId in commentIds {
            let commentDocument = FirestoreConstants.CommentsCollection.document(commentId)
            do {
                let comment = try await commentDocument.getDocument(as: Comment.self)
                comments.append(comment)
            }
            catch {print("\nDEBUG: couldnt convert document -> Comment.self\n")}
            
        }
        return comments
    }
    
    func fetchCommentSection(postId: String) async throws -> CommentSection {
        let commentSection = try await FirestoreConstants.CommentSectionCollections.document(postId).getDocument(as: CommentSection.self)
        return commentSection
    }
}
