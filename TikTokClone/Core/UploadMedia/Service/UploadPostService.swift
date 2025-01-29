//
//  UploadPostService.swift
//  TikTokClone
//
//  Created by Brody on 1/28/25.
//


import UIKit
import Firebase
import FirebaseAuth

class UploadPostService: ObservableObject {
    
    private let videoUploader: VideoUploader
    
    init(videoUploader: VideoUploader) {
        self.videoUploader = videoUploader
    }
    
    func uploadPost(_ inputUrl: URL, caption: String) async {
        do {
            let postUrl = try await videoUploader.uploadVideo(videoURL: inputUrl) // returns firebase url
            try await updateUserPostDict(postUrl, caption: caption)
        } catch {
            print("DEBUG: Handle video uploader error here...")
        }
    }
    
    func updateUserPostDict(_ videoUrl: String?, caption: String) async throws {
        guard let videoUrl else { return }
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let timeStamp = formatDate()
        
        let postId = NSUUID().uuidString
        let postData: [String: Any] = [
            "postId": postId,
            "id": currentUid, // userId
            "videoUrl": "\(videoUrl)",
            "timestamp": timeStamp,
            "caption": caption,
            "likesAmount": 0,
            "commentsAmount": 0,
            "savesAmount": 0
        ]
        
        // Uploads postData to firebase under postId
        try await FirestoreConstants.PostCollection.document(postId).setData(postData)
        
        // Uploads new post to userDatabase
        try await FirestoreConstants.UsersCollection.document(currentUid).updateData([
            "postIds": FieldValue.arrayUnion([postId])
        ])
    }
    
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss" 
        let dateString = formatter.string(from: Date())
        return dateString
    }
    
}

// Storage concept

//        /Users/{userId}/
//            ├── username: "Brody"
//            ├── postIds: ["post001", "post002", "post003"]
//
//        /Posts/{post001}/
//            ├── postId: "post001"
//            ├── userId: "user123"
//            ├── videoUrl: "sfsefksekfskefk.mp4"
//            ├── caption: "caption message"
//            ├── timestamp: 1706467200
